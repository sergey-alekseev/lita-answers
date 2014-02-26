class Knowledgebase
  REDIS_NAMESPACE = 'handlers:answers'
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
      @redis ||= Redis::Namespace.new(REDIS_NAMESPACE, redis: Lita.redis)
    end
  end
end
