# Example configuration:
#
# EnsureNoSortPipeUniq:
#   enabled: true
#   include:
#     - '**/*.sh'
module Overcommit
  module Hook
    module PreCommit
      # Prevent 'sort | uniq' from happening as 'sort -u' is faster
      class EnsureNoSortPipeUniq < Base
        def run
          errors = []

          check_files.each do |file|
            match = File.read(file).match(/sort\s{0,}\|\s{0,}uniq/)
            if match
              errors << "#{file}: contains '#{match[0]}' (can be replaced with 'sort -u')"
            end
          end

          return :fail, errors.join("\n") if errors.any?

          :pass
        end

        private

        def check_files
          applicable_files.reject do |file|
            File.basename(file) =~ /^ensure_no_sort_pipe_uniq\.rb$/
          end
        end
      end
    end
  end
end
