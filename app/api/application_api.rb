class ApplicationAPI < Grape::API
  include APIGuard
  mount V1::Base
end