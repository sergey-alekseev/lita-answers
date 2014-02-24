require 'lita'
require 'pry'

module Lita
  module Handlers
    class Answers < Handler
      QUESTION_REGEX = /[\w\s]+\?/
      ANSWER_REGEX = /[\w\s]+\.?/

      route(/^all\squestions$/i, :index, command: true, help: {
        "all questions'" => "You could ask me the following questions:\n1) ...\n2) ..."
      })

      route(/^remember\s'(#{QUESTION_REGEX.source})'\swith\s'(#{ANSWER_REGEX.source})'$/i, :create, command: true, help: {
        "remember 'question?' with 'answer.'" => "The answer for 'question' is 'answer'."
      })

      route(/^answer\s'(#{QUESTION_REGEX.source})'$/i, :show, command: true, help: {
        "answer 'question?'" => "answer."
      })

      route(/^change\s'(#{QUESTION_REGEX.source})'\sto\s'(#{ANSWER_REGEX.source})'$/i, :update, command: true, help: {
        "change 'question?' to 'new answer.'" => "The new answer for 'question' is 'new answer'."
      })

      route(/^forget\s'(#{QUESTION_REGEX.source})'$/i, :destroy, command: true, help: {
        "forget 'question?'" => "Forgot 'question?'"
      })

      def index(response)
        reply = "You could ask me the following questions:"
        questions = Knowledgebase.all
        questions.map.with_index do |question, index|
          reply << "\n#{index+1}) #{question}"
        end
        response.reply(reply)
      end

      def create(response)
        question, answer = response.matches.first
        Knowledgebase.create(question, answer)
        response.reply("The answer for '#{question}' is '#{answer}'")
      end

      def show(response)
        question = response.matches.first
        answer = Knowledgebase.read(question)
        response.reply(answer)
      end

      def update(response)
        question, new_answer = response.matches.first
        Knowledgebase.update(question, new_answer)
        response.reply("The new answer for '#{question}' is '#{new_answer}'.")
      end

      def destroy(response)
        question = response.matches.first[0]
        Knowledgebase.destroy(question)
        response.reply("Forgot '#{question}'")
      end
    end

    Lita.register_handler(Answers)
  end
end
