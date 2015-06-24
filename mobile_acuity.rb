module MobileAcuity

  DATANAME = "ma" # your Mobile Acuity account name
  DEFAULT_DATASET = "dataset_1" # dataset to search

  def self.create(image_path, dataset = DEFAULT_DATASET, some_value = "foo")
      curl = Curl::Easy.new("http://api.mobileacuity.net/v1/data/#{DATANAME}/datasets/#{dataset}/images?value=#{URI.encode(some_value)}")
      # MA will give you a "400 - Bad Request" if you try removing the params hash, there needs to be at least 1 kv pair
      curl.headers["Content-Type"] = "image/jpeg"
      curl.headers["Accept"] = "text/json"
      curl.post_body = File.read(image_path)
      curl.http_post
      
      return curl.body_str
  end
  
  
    def self.search(image_path, accept = :json, dataset = DEFAULT_DATASET)
      curl = Curl::Easy.new("http://api.mobileacuity.net/v1/search/#{DATANAME}/#{dataset}")
      curl.headers["Content-Type"] = "image/jpeg"
      if accept == :json
        curl.headers["Accept"] = "text/json"
      end
      curl.post_body = File.read(image_path)
      curl.http_post
      if accept == :json
        return JSON.parse(curl.body_str)
      else
        return curl.body_str
      end
  end

end
