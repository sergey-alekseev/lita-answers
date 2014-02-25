require 'lita'

module Lita
  module Handlers
    class Answers < Handler
      TEXT = /[\w\s\,\.\-\/:–]+/
      QUESTION = /(?:'|")(#{TEXT.source}\?)(?:'|")/
      ANSWER = /(?:'|")(#{TEXT.source}\.?)(?:'|")/

      route(/^all\squestions$/i, :index, command: true, help: {
        "all questions" => "You could ask me the following questions: 1) ... 2) ..."
      })

      route(/^remember\s#{QUESTION.source}\swith\s#{ANSWER.source}$/i, :create, command: true, help: {
        "remember 'question?' with 'answer.'" => "The answer for 'question' is 'answer'."
      })

      route(/^answer\s#{QUESTION.source}$/i, :show, command: true, help: {
        "answer 'question?'" => "answer."
      })

      route(/^change\s#{QUESTION.source}\sto\s#{ANSWER.source}$/i, :update, command: true, help: {
        "change 'question?' to 'new answer.'" => "The new answer for 'question' is 'new answer'."
      })

      route(/^forget\s#{QUESTION.source}$/i, :destroy, command: true, help: {
        "forget 'question?'" => "Forgot 'question?'"
      })

      def index(response)
        questions = Knowledgebase.all
        if questions.any?
          reply = "You could ask me the following questions:"
          questions.map.with_index do |question, index|
            reply << "\n#{index+1}) #{question}"
          end
        else
          reply = "There are no questions yet! " \
                  "Use REMEMBER 'question?' WITH 'answer.' syntax for creating questions!\n" \
                  "For more info see: help remember."
        end
        response.reply(reply)
      end

      def create(response)
        question, answer = response.matches.first
        if Knowledgebase.exists?(question)
          answer = Knowledgebase.read(question)
          reply = "Use CHANGE 'question?' TO 'new answer.' syntax for existing questions! " \
                  "For more info see: help change.\n" \
                  "The answer for '#{question}' is still '#{answer}'"
        else
          Knowledgebase.create(question, answer)
          reply = "The answer for '#{question}' is '#{answer}'"
        end
        response.reply(reply)
      end

      def show(response)
        question = response.matches.first
        reply = Knowledgebase.read(question) || 'There is no such a question! Use ALL QUESTIONS command.'
        response.reply(reply)
      end

      def update(response)
        question, new_answer = response.matches.first
        if Knowledgebase.exists?(question)
          Knowledgebase.update(question, new_answer)
          reply = "The new answer for '#{question}' is '#{new_answer}'."
        else
          reply = 'There is no such a question! Use ALL QUESTIONS command.'
        end
        response.reply(reply)
      end

      def destroy(response)
        question = response.matches.first[0]
        if Knowledgebase.exists?(question)
          Knowledgebase.destroy(question)
          reply = "Forgot '#{question}'"
        else
          reply = 'There is no such a question! Use ALL QUESTIONS command.'
        end
        response.reply(reply)
      end
    end

    Lita.register_handler(Answers)
  end
end
