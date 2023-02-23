Sentry.init do |config|
    config.dsn = 'https://801f28aefbc44e5e9ef9004b6a0c41db@sentry.shefcompsci.org.uk/75'
  
    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    config.traces_sample_rate = 0.5
    # or
    config.traces_sampler = lambda do |context|
      true
    end
  end