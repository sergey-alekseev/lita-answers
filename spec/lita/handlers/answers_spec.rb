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
      it 'remembers question with answer' do
        expect(replies.last).to eq("The answer for '#{question}' is '#{answer}'")
      end
    end

    describe '#index' do
      it 'displays all questions' do
        send_command 'all questions'
        expect(replies.last).to eq "You could ask me the following questions:\n" \
                                   "1) #{question}"
      end
    end

    describe '#show' do
      it 'answers the question' do
        send_command "answer '#{question}'"
        expect(replies.last).to eq(answer)
      end
    end

    describe '#destroy' do
      it 'forgets the question' do
        send_command "forget '#{question}'"
        expect(replies.last).to eq("Forgot '#{question}'")
      end
    end

    describe '#update' do
      it 'changes the answer for the question' do
        send_command "change '#{question}' to '#{new_answer}'"
        expect(replies.last).to eq("The new answer for '#{question}' is '#{new_answer}'.")
      end
    end
  end
end
