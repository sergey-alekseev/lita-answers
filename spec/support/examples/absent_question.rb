shared_examples 'absent question' do |command|
  it 'says that there is no such a question' do
    send_command command
    expect(replies.last).to eq("There is no such a question! Use ALL QUESTIONS command.")
  end
end
