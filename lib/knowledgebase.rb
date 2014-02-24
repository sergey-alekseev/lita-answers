class Knowledgebase
  REDIS_KEY = 'knowledgebase'

  class << self
    def all
      redis.hkeys(REDIS_KEY)
    end

    def create(question, answer)
      redis.hset(REDIS_KEY, question, answer)
    end

    def read(question)
      redis.hget(REDIS_KEY, question)
    end

    def update(question, answer)
      redis.hset(REDIS_KEY, question, answer)
    end

    def destroy(question)
      redis.hdel(REDIS_KEY, question)
    end

    def exists?(question)
      redis.hexists(REDIS_KEY, question)
    end

    def redis
      @redis ||= Redis::Namespace.new(redis_namespace, redis: Lita.redis)
    end

    private

      def redis_namespace
        ENV['env'] == 'test' ? 'handlers:answers:test' : 'handlers:answers'
      end
  end
end
