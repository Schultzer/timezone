use Mix.Config

config :timezone,
  base_api_url: "https://maps.googleapis.com"

import_config "#{Mix.env}.exs"
