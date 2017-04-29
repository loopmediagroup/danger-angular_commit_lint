def extractSubject(message)
  return message[:subject].split(': ')[1] ||= message[:subject]
end

module Danger
  class DangerCommitLint < Plugin
    # TODO: Split this checker to multiple checkers and then use self.type values to switch on / off
    # Don't know about the commit
    class SubjectPatternCheck < CommitCheck # :nodoc:
      def message
        scope_option = @useScope ? '(<scope>)' : ''
        scope_required = ''
        if @useScope
          scope_required = "<scope> must be at least #{@minScope} characters#{@scopeRequired ? 'or ommitted' : ''}"
        end
        "Please follow the commit format `<type>#{scope_option}: <subject>`.\n`<type>` must be one of #{@commitTypes.join ', '}".freeze
      end

      def self.type
        :subject_pattern
      end
      
      def initialize(message, config = {})
        @commitTypes = config.fetch(:commit_types, [
          'fix', 'feat', 'docs', 'style', 'refactor', 'test', 'chore'
          ])
        @useScope = config.fetch(:use_scope, true)
        @minScope = config.fetch(:min_scope, 1)
        @requireScope = config.fetch(:require_scope, false)
        scopeRegex = @useScope ? "(\\([a-zA-Z0-9-]{#{@minScope},}\\)|\\(\\)#{@requireScope ? '' : '|'})" : ''
        @regex_string = "^(#{@commitTypes.join '|'})#{scopeRegex}: .+$"
        @subject = message[:subject]
      end

      def fail?
        (@subject =~ Regexp.new(@regex_string)) == nil
      end
    end
  end
end
