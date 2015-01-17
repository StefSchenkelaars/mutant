module Mutant
  # Parallel excecution engine of arbitrary payloads
  module Parallel

    # Async for parallelized execution
    class Async
      include Concord.new(:binding)

      # Return scheduler status
      #
      # @return [Object]
      #
      # @api private
      #
      def status
        binding.call(__method__)
      end

      # Stop master gracefully
      #
      # @return [self]
      #
      # @api private
      #
      def stop
        binding.call(__method__)
        self
      end
    end # Async

    # Run async computation returing driver
    #
    # @return [Async]
    #
    # @api private
    #
    def self.async(config)
      Async.new(config.env.new_mailbox.bind(Master.call(config)))
    end

    # Job result sink
    class Sink
      include AbstractType

      # Process job result
      #
      # @param [Object]
      #
      # @return [self]
      #
      # @api private
      #
      abstract_method :result

      # Return status
      #
      # @return [Object]
      #
      # @api private
      #
      abstract_method :status

      # Test if processing should stop
      #
      # @return [Boolean]
      #
      # @api private
      #
      abstract_method :stop?
    end # Sink

    # Job to push to workers
    class Job
      include Adamantium::Flat, Anima.new(:index, :payload)
    end # Job

    # Job result object received from workers
    class JobResult
      include Adamantium::Flat, Anima.new(:job, :payload)
    end # JobResult

    # Parallel run configuration
    class Config
      include Anima::Update, Adamantium::Flat, Anima.new(:env, :processor, :source, :sink, :jobs)
    end # Config

    # Parallel execution status
    class Status
      include Adamantium::Flat, Anima::Update, Anima.new(:payload, :done, :active_jobs)
    end

  end # Parallel
end # Mutant
