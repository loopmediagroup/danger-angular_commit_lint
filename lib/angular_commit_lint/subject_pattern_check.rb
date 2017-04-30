def extract_subject(message)
  message[:subject].split(': ')[1] ||= message[:subject]
end

# rubocop:disable Metrics/LineLength

module Danger
  class DangerAngularCommitLint < Plugin
    class SubjectPatternCheck < CommitCheck # :nodoc:
      DEFAULT_TYPES = %w[fix feat docs style refactor test chore].freeze

      def message
        scope_option = @use_scope ? '(<scope>)' : ''
        scope_required = ''
        if @use_scope
          scope_required = "\n<scope> must be at least #{@min_scope} characters#{@scope_required ? 'or ommitted' : ''}"
        end
        "Please follow the commit format `<type>#{scope_option}: <subject>`.#{scope_required}\n`<type>` must be one of #{@commit_types.join ', '}".freeze
      end

      def self.type
        :subject_pattern
      end

      def initialize(message, config = {})
        @commit_types = config.fetch(:commit_types, DEFAULT_TYPES)
        @use_scope = config.fetch(:use_scope, true)
        @min_scope = config.fetch(:min_scope, 1)
        @require_scope = config.fetch(:require_scope, false)
        scope_regex = ''
        if @use_scope
          scope_regex = "(\\([a-zA-Z0-9-]{#{@min_scope},}\\)|\\(\\)#{@require_scope ? '' : '|'})"
        end
        @regex_string = "^(#{@commit_types.join '|'})#{scope_regex}: .+$"
        @subject = message[:subject]
      end

      def fail?
        (@subject =~ Regexp.new(@regex_string)).nil?
      end
    end
  end
end

# rubocop:enable Metrics/LineLength
