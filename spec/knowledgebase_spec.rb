require 'spec_helper'

describe Knowledgebase do
  include_context 'variables'

  subject { Knowledgebase }
  before { subject.create(question, answer) }

  describe '.all' do
    it 'returns all questions' do
      expect(subject.all).to eq([question])
    end
  end

  describe '.create(question, answer)' do
    it 'sets the key to question and the value to answer' do
      subject.create(question, answer)
      expect(subject.read(question)).to eq(answer)
    end
  end

  describe '.read(question)' do
    it 'returns the answer for the question' do
      expect(subject.read(question)).to eq(answer)
    end
  end

  describe '.update(question, answer)' do
    it 'updates the answer for the question' do
      subject.create(question, answer)
      subject.update(question, new_answer)
      expect(subject.read(question)).to eq(new_answer)
    end
  end

  describe '.destroy(question)' do
    it 'destroys question' do
      subject.create(question, answer)
      subject.destroy(question)
      expect(subject.read(question)).to be_nil
    end
  end
end
