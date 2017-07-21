![Watch Nature](https://d3vv6lp55qjaqc.cloudfront.net/items/431I0r241o3d2J1S1625/logo%20name%20slogan%20on%20white%20900%20wide.png)

# Watch Nature API
An Elixir-based API for our social field guide to Life on Earth. Serves our Vue-based web client.

- [Watch Nature Project](https://watchnature.co)
- [Project Progress Board](https://github.com/WatchNature/watchnature-web/projects/1)
- [Project Wiki](https://github.com/WatchNature/watchnature-web/wiki)
- [Project Issues](https://github.com/WatchNature/watchnature-web/issues)

## Development

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd ./assets && yarn install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

To run the tests and watcher, simply use `mix test.watch`.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

### Environment Vars

Environment variables for the backend are loaded from `.env` located in the project root. The skeleton:

```
export CLOUDEX_API_KEY="YOUR_KEY"
export CLOUDEX_SECRET="YOUR_KEY"
export CLOUDEX_CLOUD_NAME="YOUR_CLOUD_NAME"
```

Environment variables for the frontend are loading from `config/development.js`. The skeleton:

```
{
  URL: JSON.stringify('http://localhost:4000'),
  ENV: JSON.stringify('development'),
  API_BASE_URL: JSON.stringify('http://localhost:4000/api'),
  APP_BASE_URL: JSON.stringify('http://localhost:4000'),
  GOOGLE_MAPS_API_KEY: JSON.stringify('YOUR_KEY_HERE'),
  IMGIX_SOURCE: JSON.stringify(''),
  IMGIX_SOURCE_HOSTNAME: JSON.stringify(''),
  DOCUMENT_TITLE_BASE: JSON.stringify('[DEV] Watch Nature'),
  DOCUMENT_TITLE_SEPARATOR: JSON.stringify('»'),
  GA_ID: JSON.stringify('')
}
```

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Team

- [Brady Swenson](https://github.com/orgs/WatchNature/people/bradyswenson) - Cofounder, Chief Executive, Product Lead
- [Sean Washington](https://github.com/orgs/WatchNature/people/seanwash) - Cofounder, Chief Technologist
- [Nicholas Stahl](https://www.instagram.com/nicholasryanstahl/) - Cofounder, Chief Designer

## License
Watch Nature is released under the [GNU Public License v3](https://opensource.org/licenses/GPL-3.0).

