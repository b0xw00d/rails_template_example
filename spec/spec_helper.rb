RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

=begin
  config.filter_run_when_matching :focus

  config.example_status_persistence_file_path = "spec/examples.txt"

  config.disable_monkey_patching!

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed
=end
end

if defined? RSpec::Core::Formatters::ProgressFormatter
  RSpec::Core::Formatters::ProgressFormatter.class_eval do
    DOTS = ["✅ ", "⚠️ ", "❌ "]

    def example_passed(_example)
      output.print DOTS[0]
    end

    def example_pending(_example)
      output.print DOTS[1]
    end

    def example_failed(_example)
      output.print DOTS[2]
    end
  end
end

