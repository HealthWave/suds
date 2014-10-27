# suds

Welcome to the suds project. This is very much a work in progress, so please use this at your own risk. I am changing the DSL constantly and rewriting the history.

This project will become stable fairly soon.

Suds is a essentially a tool for working with data files. Suds is broken up into three modular components: **interpreters**, **cleaners**, and **converters**.

**Interpreters** load the data into the `suds` object. This can be in the form of raw text, json, csv, etc. Interpreteres can be chained together, for instance a (fictional) `GoogleDriveInterpreter` can pass it's data to the  `CSVInterpreter`.

**Cleaners** manipulate the data. You can modify/remove rows/columns (in the context of a CSV file).

**Converters** export the file either to disk or to a remote location.


## Requirements

Ruby `2.0.x` is tested. If you need support for `1.9.3` use the `1.9.3` branch.


## Installation

```bash
gem install suds
```

Or if you're using Bundler, include the following line in your Gemfile:

```ruby
gem 'suds', git: 'git@github.com:HealthWave/suds.git'
```

## Getting started starting

Initialize your interpreter(s):


```ruby
f_interpreter = FileInterpreter.new('./path/to/my/file')
csv_interpreter = CSVInterpreter.new(f_interpreter.data)
```

Create a suds list and add the interpreters to it:

```ruby
list = Suds.new( csv_interpreter )
```

Add some cleaners to it:

```ruby
list.add_cleaner Cleaner.new {|_,v| v.strip! if v } # Inline initialization of a generic cleaner
# Configuring an existing cleaner
list.add_cleaner ColumnConverterCleaner.new({
  company:     :name,
  nlacno:      :partner_practitioner_id,
})
list.add_cleaner ColumnFilterCleaner.new(include_columns: [:name, :partner_practitioner_id, :email])
list.add_cleaner DowncaseCleaner.new()
```

Run all the cleaners:

```ruby
list.clean
```


