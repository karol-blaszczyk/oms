shared_context '200 ok' do
  it { is_expected.to respond_with 200 }
end

shared_context '422 unprocessable entity' do
  it { is_expected.to respond_with 422 }
end

shared_context '403 unauthorized' do
  it { is_expected.to respond_with 403 }
  it do
    expect(last_json_response)
      .to eq(
        'errors' => 'You are not authorized to access this page.'
      )
  end
end

shared_context '404 not_found' do |type|
  it { is_expected.to respond_with 404 }
  it do
    expect(last_json_response['errors'])
      .to include("Couldn't find #{type}")
  end
end
