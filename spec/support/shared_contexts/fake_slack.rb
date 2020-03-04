shared_context 'fake_slack' do
  before(:each) do
    allow_any_instance_of(SlackNotifier).to receive(:m_send).and_return(true)
  end
end
