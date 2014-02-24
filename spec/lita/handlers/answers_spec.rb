require 'spec_helper'

describe Lita::Handlers::Answers, lita_handler: true do
  include_context 'variables'

  describe 'routes' do
    it { routes_command("remember 'question?' with 'answer.'").to :create }
    it { routes_command("change 'question?' to 'answer.'").to :update }
    it { routes_command("answer 'question?'").to :show }
    it { routes_command("forget 'question?'").to :destroy }
    it { routes_command("all questions").to :index }
  end

  describe 'commands' do
    before { send_command "remember '#{question}' with '#{answer}'" }

    describe '#create' do
      it 'remembers the question with an answer' do
        expect(replies.last).to eq("The answer for '#{question}' is '#{answer}'")
      end

      it "doesn't remember the existing question" do
        send_command "remember '#{question}' with 'abrakadabra'"
        expect(replies.last).to eq("Use CHANGE 'question?' TO 'new answer.' syntax for existing questions! " \
                                   "For more info see: help change.\n" \
                                   "The answer for '#{question}' is still '#{answer}'")
      end
    end

    describe '#index' do
      it 'displays all questions' do
        send_command 'all questions'
        expect(replies.last).to eq "You could ask me the following questions:\n" \
                                   "1) #{question}"
      end

      context 'no questions' do
        it 'displays help explanation' do
          send_command "forget '#{question}'"
          send_command 'all questions'
          expect(replies.last).to eq("There are no questions yet! " \
                                     "Use REMEMBER 'question?' WITH 'answer.' syntax for creating questions!\n" \
                                     "For more info see: help remember.")
        end
      end
    end

    describe '#show' do
      it 'answers the question' do
        send_command "answer '#{question}'"
        expect(replies.last).to eq(answer)
      end

      it_behaves_like 'absent question', "answer 'abrakadabra?'"
    end

    describe '#destroy' do
      it 'forgets the question' do
        send_command "forget '#{question}'"
        expect(replies.last).to eq("Forgot '#{question}'")
      end

      it_behaves_like 'absent question', "forget 'abrakadabra?'"
    end

    describe '#update' do
      it 'changes the answer for the question' do
        send_command "change '#{question}' to '#{new_answer}'"
        expect(replies.last).to eq("The new answer for '#{question}' is '#{new_answer}'.")
      end

      it_behaves_like 'absent question', "change 'abrakadabra?' to 'abrakadabra'"
    end
  end
end
