require "bundler"
# require "gem_tasks"
require "curb"
require "oj"
task :default => :spec

BASE_URL = "https://api.vk.com/api.php?oauth=1&"

def vk_method(method:, params: {}, count: 1000, offset: 0)
  q = params.map{|k,v| "#{k}=#{v.is_a?(Array) ? v.join(',') : v}"}.join('&')
  url = "#{BASE_URL}method=#{method}&v=5.60&lang=ru&count=#{count}&offset=#{offset}&#{q}"
  puts url
  http = Curl.get(url)
  json = Oj.load(http.body_str)
  if json["response"]["count"] > count && json["response"]["items"].size > 0
    json["response"]["items"] = json["response"]["items"].concat(vk_method(method: method, 
      params: params, 
      count: count, 
      offset: offset + count))
  end
  json["response"]["items"]
end

task :update do
  countries = {}
  ({"Россия" => 1, "Украина" => 2, "Беларусь" => 3}).each do |key, id|
    countries[key] ||= {}
    vk_method(method: "database.getRegions", params: {country_id: id}).each do |region|
      countries[key][region["title"]] ||= {}
      cities = vk_method(method: "database.getCities", params: {country_id: id, region_id: region["id"]})
      cities.each do |city|
        countries[key][region["title"]][city["area"]] ||= {}
        countries[key][region["title"]][city["area"]][city["title"]] ||= {}
      end
    end
  end
  File.open(File.join(File.dirname(__FILE__), 'db/data.json'), "w").write(Oj.dump(countries))
end