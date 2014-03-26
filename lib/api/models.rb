module API
  module V1
    class Document
      include Her::Model
      uses_api OlpApi::V1.api

      attributes :headline
    end
  end
end