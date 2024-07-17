Rails.application.routes.draw do
  root to: proc { [200, {}, ['Test Deploying']] }
end
