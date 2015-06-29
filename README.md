# Website Skeleton: a template for your site

The canonical site is https://github.com/maruel/webskel. *Please read the
instructions there as they may have been updated*.


## Features

  - Flexible. Create:
    - A static web page site (e.g. small website for a small shop, personal
      page, etc) that is not meant to be updated frequently.
    - A full featured blog.
    - Or both!
  - No programming needed at all! Complete site can be deployed only with a web
    browser.
  - Instructions included below to get free web hosting and free HTTPS support
    for a professional look.

Further;

  - Mobile first design. Looks great on mobile *and* on desktop.
  - Retina-ready icons for popular web sites to look great on
    iPhone/iPad/MacBook Pro/etc:
    - <img src="/static/images/facebook.png" width=32 height=32 />
    <img src="/static/images/twitter.png" width=32 height=32 />
    <img src="/static/images/linkedin.png" width=32 height=32 />
    <img src="/static/images/gplus.png" width=32 height=32 />
    <img src="/static/images/youtube.png" width=32 height=32 />
    <img src="/static/images/github.png" width=32 height=32 />
    <img src="/static/images/email.png" width=32 height=32 />
  - Includes meta data for Facebook, Twitter, Google and Bing. When a user
    shares a link to a page on your web site, Twitter/Facebook/etc will
    automatically generate the right summary based on the page content,
    including your Twitter account reference, company logo as specified in
    [config.toml](config.toml), etc.
  - Includes everything to be indexed by Google and Bing including great
    snippets.
  - [Google Analytics](https://www.google.com/analytics/) support to track your
    audience.
  - The code was handcrafted to be very efficient and easy to read and modify.


## Prerequisites

  - Buy a domain name. If you don't know what registrar to use, try [Google
    Domains](https://google.com/domains), it's cheap and privacy registration is
    free. The following assumes you are using Google Domains.
    - This document uses `your.domain` as your domain name. Replace it with
      yours.


## Accounts

The instructions below assumes you are logged in into these 3 accounts:

  - Visit [github.com](https://github.com). Click `Sign up` and chose the Free
    plan.
    - Every time you see `USER` in the instructions below, replace it with your
      GitHub user account name.
  - Visit [codeship.com](https://codeship.com). Click `SIGN UP FOR FREE`.
    - Choose `SIGN UP WITH GITHUB`.
    - Click `Authorize application`. Stop there and leave the tab open.
  - Visit [cloudflare.com](https://cloudflare.com). Click `Sign up` and create
    an account. Stop there and leave the tab open.


## Steps

  - Visit [github.com/new](https://github.com/new). Create a new repository
    named `USER.github.io`. Replace `USER` with your GitHub username. This will
    contain the actual files of the website. Click `Create repository`.
  - Visit [github.com/maruel/webskel](https://github.com/maruel/webskel). Click
    the `Fork` button at the top right.
  - At this point, you have two repositories: `USER.github.io` and `webskel`.
  - You should be on [github.com/USER/webskel](https://github.com/USER/webskel),
    as usual replacing `USER` with your GitHub username.
  - The files in `content/`, `layouts/` contain a lot of comments and things to
    update. Read the files, it will define the look and feel of your page and
    will setup the initial metadata (your picture, email address, etc).
  - For every file below, click on it, click the small pen *Edit* button.
    Replace every instance of `CHANGE_ME` with the relevant content.  For
    example for `email`, use an email address you want to appear on your
    website, if desired. For every file, save the change to generate a commit.
    The files that need to be changed are:
    - [config.toml](./config.toml); This file is the global website's settings.
      It is the most important file.
    - [layouts/index.html](layouts/index.html); This file is the root page of
      your website.
    - [layouts/partials/header_common.html](layouts/partials/header_common.html);
      This file is injected at the top of every pages on your web site.
    - [static/CNAME](static/CNAME); This file tells GitHub what is your domain
      name.
    - [content/page/](content/page/) is where you put non-blog
      pages like *about you* or a page describing the company. You can add as
      many as you want. You can delete the default ones too.
      - [content/page/about.md](content/page/about.md)
      - [content/page/projects.md](content/page/projects.md)
    - [content/post/](content/post/) is where the blog posts are located. This
      is optional.
      - [content/post/new.md](content/post/new.md); This is an example of a blog
        post.
  - Visit [codeship.com](https://codeship.com) to activate your codeship
    project.
    - Click the big green button.
    - Click the awkward GitHub button.
    - Select `USER/webskel`.
    - Scroll down to `Configure Test Pipelines` section at the bottom, remove
      all the text in the black edit box and type:
      `./generate.sh`
    - Codeship is a bit tone deaf and requires you to make a change to your
      repository at that point, so go back to
      [github.com/USER/webskel](https://github.com/USER/webskel), edit a file,
      make a dummy change and commit it.
    - Once you did a change, go back to [codeship.com](https://codeship.com) and
      there should be a `RUNNING` build that eventually becomes `SUCCESS`.
    - Click `Project Settings` at top right.
    - Click `Deployment`.
    - Type `master`.
    - Click `Save pipeline settings`.
    - Click `Custom Script` (the last item).
    - In the black edit box, type: `./publish.sh`
    - Click `Create`.
    - This enables the conversion of sources from `webskel` into the website at
      `USER.github.io` everytime `webskel` is changed.
  - Now you need to fix something. Codeship has added its private key to
    `webskel` but we want it to push to `USER.github.io` so we need to make a
    small change:
    - Click `General` on the left.
    - Copy the `SSH public key`; it's a long string starting with `ssh-rsa
      AA`... Select it all and Ctrl-C.
    - Visit
      [github.com/USER/webskel/settings/keys](https://github.com/USER/webskel/settings/keys).
    - Click the red button *Delete*.
    - Visit
      [github.com/USER/USER.github.io/settings/keys](https://github.com/USER/USER.github.io/settings/keys).
      Click *Add deploy key*.
      - Title use `codeship`.
      - Ctrl-V (paste) the SSH public key there.
      - Click `Allow write access`.
      - Click `Add key`.
  - Visit [cloudflare.com/a/setup](https://cloudflare.com/a/setup) to enable
    HTTPS serving.
    - Type `your.domain` at the bottom.
    - Wait 60 seconds and click `Continue`.
    - Choose `A`, Type `your.domain` as Name, `192.30.252.153`, click Add Record.
    - Choose `A`, Type `your.domain` as Name, `192.30.252.154`, click Add Record.
    - Choose `CNAME`, Type `www` as name, `your.domain` as Domain name, click Add
      Record.
    - For Google Domains only;
      - Choose `MX`, Type `@`, Select `gmr-smtp-in.l.google.com` and `5`
      - Choose `MX`, Type `@`, Select `alt1.gmr-smtp-in.l.google.com` and `10`
      - Choose `MX`, Type `@`, Select `alt2.gmr-smtp-in.l.google.com` and `20`
      - Choose `MX`, Type `@`, Select `alt3.gmr-smtp-in.l.google.com` and `30`
      - Choose `MX`, Type `@`, Select `alt4.gmr-smtp-in.l.google.com` and `40`
    - Click `Continue`.
    - Click `Free plan`, Click `Continue`.
    - Visit [domains.google.com/registrar](https://domains.google.com/registrar)
      to assign DNS server from Google Domains to CloudFlare.
      - Click your domain name.
      - Make sure that email forwarding is configured.
      - Click the 3rd button `Configure DNS`.
      - Click `Use custom name servers`.
      - Type `bonnie.ns.cloudflare.com`, click `+`. Type
        `frank.ns.cloudflare.com` and click Save.
      - You have to wait a while for CloudFlar serving to be enabled. It can be
        a good hour. Go grab a lunch.


## Optimizing

  - Visit
    [google.com/webmasters/tools/home](https://google.com/webmasters/tools/home)
    to setup Google search settings.
  - Visit [bing.com/toolbox/webmaster](https://bing.com/toolbox/webmaster) to
    setup Bing search settings.
  - Visit [www.google.com/analytics](https://www.google.com/analytics) to get
    data about the audience.


## Adding or editing content

You should now visit https://your.domain and see your new website.

To add a new page or a new blog post:

  - Visit
    [github.com/USER/webskel/tree/master/content/page/)](https://github.com/USER/webskel/tree/master/content/page/).
    In practice, click through from
    [github.com/USER/webskel](https://github.com/USER/webskel) on `content`,
    then `page`. Use `post` for a new blog post.
  - Click on the little `+` at the top next to the `page` word.
  - Give a name to your file. This will become part of the URL so use something
    nice.
  - Write content. Use the following as the initial content of the page:

```
+++
# Lines starting with a # are comments.

# For `page` content, use 0001-01-?? as the date, the day is used to order the
# pages in reverse order. It will not be shown, it is only used to order the
pages in the toolbar # at the top.
#
# For `post` content, use today's date. It will be shown everywhere the post is
# listed.
date = "2015-01-01"

# The title of the page should be short. It'll be shown at the top of the page
# and will be used when shared on Facebook/Twitter:
title = "Title of the page"

# The summary is slighly longer but should still be short, under 200 letters. It
# will also be used on Facebook/Twitter and will appear on Google's search
# result snippets.
summary = "Short summary of the page"

# The actual content starts after the following line:
+++

Enter content here.
```

  - Modify the content: use [GitHub Flavored
    Markdown](https://help.github.com/articles/github-flavored-markdown/)
    reference page for how to format your page.
    - https://help.github.com/articles/markdown-basics/ gives basics.
    - https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet is an
      unofficial visual help guide that may be more helpful.
  - Click the green button `Commit new file`.
  - Wait one minute for codeship to process your new commit.
  - The new page should be live on the website as Codeship generated the new
    website.


## Local viewing

To iterate faster, it is useful to look at the website locally so you can look
at changes and see the effect immediately. Hugo is great in this case since the
webpage updates automatically as you save a file. Follow these steps:

  - Visit [gohugo.io](https://gohugo.io). Click Download and download the right
    version for your computer. Then install it.
  - Run: `hugo server -w `
    - On OSX or Linux, you can use instead: `./serve.sh` The reason is that it
      opens the website to the local network, which permits looking at the
      website via a tablet or a phone to confirm the mobile experience is good.
      On Windows, you have to use `hugo server --bind=0.0.0.0 -w -b
      MACHINE_NAME` where `MACHINE_NAME` is the name of your computer on the
      network.


## Credits

### Services

Thanks to all 3 services (GitHub, Codeship and CloudFlare) making this possible
for free:

  - Static files hosting is done through [github personal
    pages](https://pages.github.com/). The redirection from http://your.domain
    to https://USER.github.io is done via [CNAME
    file](https://help.github.com/articles/adding-a-cname-file-to-your-repository/).
  - Continuous deployment is done via https://codeship.com, so that modifying
    MarkDown files via GitHub's UI automatically regenerate the site and deploys
    automatically.
  - HTTPS serving is done via https://cloudflare.com. It also does the
    transparent https://your.domain -> https://USER.github.io conversion under
    the cover.


### Software

Thanks to these projects to simplify making a mobile-first website for free:

  - Uses [Hugo](https://gohugo.io/) to convert markdown files into a static
    site.
    - It is programmed in [Go](https://golang.org).
  - CSS is based on https://bootswatch.com/yeti/ by Thomas Park. Code released
    under the MIT License.
  - Uses [bootstrap](http://getbootstrap.com/) and [jquery](https://jquery.com/)
    for a mobile first experience.


## License

This software is copyrighted Marc-Antoine Ruel. It is licensed with an Apache
2.0 license.
