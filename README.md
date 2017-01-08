# Commit Lint for Danger

[![Build Status](https://travis-ci.org/jonallured/danger-commit_lint.svg?branch=master)](https://travis-ci.org/jonallured/danger-commit_lint)

This is a [Danger Plugin][danger] that ensures nice and tidy commit messages.
The checks performed on each commit message are inspired by [Tim Pope's blog
post][tpope] on good commit messages, echoed by [git's own documentation][book]
on the subject.

[danger]: http://danger.systems/plugins/commit_lint.html
[tpope]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[book]: https://www.git-scm.com/book/en/v2/Distributed-Git-Contributing-to-a-Project#Commit-Guidelines

## Installation

```
$ gem install danger-commit_lint
```

## Usage

Simply add this to your Dangerfile:

```ruby
commit_lint.check
```

That will check each commit in the PR to ensure the following is true:

* Commit subject begins with a capital letter (`subject_cap`)
* Commit subject is more than one word (`subject_word`)
* Commit subject is no longer than 50 characters (`subject_length`)
* Commit subject does not end in a period (`subject_period`)
* Commit subject and body are separated by an empty line (`empty_line`)

By default, Commit Lint fails, but you can configure this behavior.

## Configuration

Configuring Commit Lint is done by passing a hash. The three keys that can be
passed are:

* `disable`
* `fail`
* `warn`

To each of these keys you can pass either the symbol `:all` or an array of
checks. Here are some ways you could configure Commit Lint:

```ruby
# warn on all checks (instead of failing)
commit_lint.check warn: :all

# disable the `subject_period` check
commit_lint.check disable: [:subject_period]
```

Remember, by default all checks are run and they will fail. Think of this as the
default:

```ruby
commit_lint.check fail: :all
```

Also note that there is one more way that Commit Lint can behave:

```ruby
commit_lint.check disable: :all
```

This will actually throw a warning that Commit Lint isn't doing anything.

## Fixing Violations

If you have a commit that has violated these rules, you might be unsure how to
fix it. Or maybe you're unsure how to update the Pull Request. The Pro Git book
has a great chapter about [Rewriting History][rewrite_history], I would highly
recommend investing some time with that one. Here are some quick tips that might
help too:

* `git commit --amend` will allow you to edit the message of the last commit you
  made. For most people this is what you want.

* `git rebase -i master` is a little more fancy, but can solve almost any other
  issue you might be up against. I'm assuming you have used a topic branch and
  that's why the `master` argument is in the command, YMMV. Once in the interact
  view, simply move to the commit that's in violation and use `r` for `reword`.
  Use this approach when you have a commit right in the middle of your work that
  needs to be updated.

After you've fixed your commit messages with commands like these, you'll still
need to update the PR. Most of the time, this is as easy as force pushing to the
topic branch your PR is based on. GitHub then magically updates the PR and all
is well with the world. Yes, I'm advising you force push, but you have to when
you change history - be careful and stay safe out there!

[rewrite_history]: https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History
