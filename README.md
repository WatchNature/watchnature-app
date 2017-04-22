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
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

To run the tests and watcher, simply use `mix test.watch`.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Roadmap

* [x] User registration & Authentication
    * [x] Utilize Bodyguard policy scope to return 404 for not found users
    * [x] Authorization - Users should only be able to edit their own details
        * [x] show
        * [x] update
        * [x] destroy
* [x] Post CRUD
    * [x] Utilize Bodyguard policy scope to return 404 for not found posts
    * [x] Authorization - Limit UD actions to users who own the resource
        * [x] index
        * [x] create
        * [x] show
        * [x] update
        * [x] destroy
* [x] Observation CRUD
    * [x] Authorization - Limit UD actions to users who own the resource
* [ ] Image Uploads
* [ ] Post Stream

## Team

- [Brady Swenson](https://github.com/orgs/WatchNature/people/bradyswenson)
- [Sean Washington](https://github.com/orgs/WatchNature/people/seanwash)

## License
Watch Nature is released under the [GNU Public License v3](https://opensource.org/licenses/GPL-3.0).

