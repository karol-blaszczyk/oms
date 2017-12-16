require 'test_helper'

class StatusTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @status_transaction = status_transactions(:one)
  end

  test 'should get index' do
    get status_transactions_url, as: :json
    assert_response :success
  end

  test 'should create status_transaction' do
    assert_difference('StatusTransaction.count') do
      post status_transactions_url, params: { status_transaction: { created_at: @status_transaction.created_at, event: @status_transaction.event, form: @status_transaction.form, order_id: @status_transaction.order_id, to: @status_transaction.to } }, as: :json
    end

    assert_response 201
  end

  test 'should show status_transaction' do
    get status_transaction_url(@status_transaction), as: :json
    assert_response :success
  end

  test 'should update status_transaction' do
    patch status_transaction_url(@status_transaction), params: { status_transaction: { created_at: @status_transaction.created_at, event: @status_transaction.event, form: @status_transaction.form, order_id: @status_transaction.order_id, to: @status_transaction.to } }, as: :json
    assert_response 200
  end

  test 'should destroy status_transaction' do
    assert_difference('StatusTransaction.count', -1) do
      delete status_transaction_url(@status_transaction), as: :json
    end

    assert_response 204
  end
end
