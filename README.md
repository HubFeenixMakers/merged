# Merged

A CMS that integrates into the rails workflow. Ie it is file based
not db based.

Changes propagate in the normal development cycle, with git, possible
branches, possible staging, possible reviews and controlled deploys.

## Usage

Merged is designed for developers to give limited editing facilities
to users. As with rails, there is great flexibility how this can be
achieved, a basic example below.

## Concepts

Merged has simple but powerful concepts and structures to define
the interactions users may have.

### Page

The core entity that may be edited is a Page. Pages contain Sections
(below) in a way defined by developers.

A Page has a type, different types may define different layouts, or rather types of Sections they may include.

A page has a name which is it's Url, Merged is not designed for nesting currently.

All data that users change is stored in the Pages' Yaml, which get
committed and __merged__ to propagate to the site.

A Page also has data, attributes and options, see below.

### Sections

Merged itself defines many styles of sections, and off course
developers may define more.
For example a Header with text is a section, a hero section is a section, and a card section is a different style.

The only defining characteristic of a section is really that it is full width, and it has a template that renders the content.

A Page may contain as many sections as the Page definition allows.

A Section in turn may contain cards.

Like a Page, a Section may have options.

### Cards

Cards, as in general css lingo, are usually smaller html snippets,
usually contained in a grid (defined by the Section).

Cards have data and options like the other elements.

### Image

Merged also manages images, adding deleting, renaming, which are
stored in the assets folder. With the Pages (and their data) they
define the content that users can change.

Images merge into the upstream in the same way as the pages, through
git actions (partially done by Merged)

## Change (-sets)

As data is in files, all change happens by git.
Merged partially manages this, by making changes visible to the
users, ie what Pages and Images were added/removed or edited.
Merged can commit and in the future maybe even push.

### Basic setup

A developer set up a machine on a intranet/lan. Ie access is
restricted by physical access.

The machine is set up as a developer machine, on a "feature" branch.
A User may use the machine to edit and commit and push (the branch).

The developer reviews, merges changes and deploys.


## Installation
Add this line to your application's Gemfile:

```ruby
gem "merged"
```

And then execute:
```bash
$ bundle
```

Mount engine in routes for editing.
```ruby
mount Merged::Engine => "/merged"
```

Create route to serve content.
```ruby
get ":id" , to: "merged/view#view" , id: :id
```

If Merged served the root:
```ruby
root "merged/view#view" , id: 'index'
```

Include merged stylesheet to your asset
pipeline. Merged switches tailwind preflight off and assumes you
use tailwind in your app or otherwise reset.

```
*= require merged/merged
```

This also means means you should have the tailwind include 
tag before the  application in your layout.

```
= stylesheet_link_tag "tailwind" , "inter-font", "data-turbo-track": "reload"
= stylesheet_link_tag "application"
```

If you use tailwind with the basic install, you must change the
order of stylesheet loaded in your application layout

## Contributing
Ask first.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
