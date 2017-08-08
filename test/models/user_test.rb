require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user= User.new(name:'Davide', email:'davide@gmail.com', 
										password:'letmein87', password_confirmation:'letmein87')
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "name should be present" do
		@user.name = "  "
		assert_not @user.valid?
	end

	test "email should be present" do
		@user.email = " "
		assert_not @user.valid?
	end

	test "name should not be too long" do
		@user.name = "a"*51
		assert_not @user.valid?
	end

	test "name should not be too short" do
		@user.name = "a"*4
		assert_not @user.valid?
	end

	test "email should not be too long" do
		@user.email = "a"*246 + "@gmail.com"
		assert_not @user.valid?
	end

	test "email validation should accept valid addresses" do
		valid_addresses = %w[davide@gmail.com linh@gmail.it ornella.nossa@libero.it virginio54@hotmail.com]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect} should be valid"
		end
	end

	test "email validation should be reject valid addresses" do
		valid_addresses = %w[davide@gmail,com linh@gmail..it ornella.nossa@libero virginio54hotmail.com]
		valid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address.inspect} should be valid"
		end
	end
	
	test "address should be unique" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be at least 6chars" do
  	@user.password = @user.password_confirmation = "a"*5
  	assert_not @user.valid?
  end

  test "password should not be blank" do
  	@user.password = @user.password_confirmation = " "*6
  	assert_not @user.valid?
  end

  test "password should contain at least one number" do
   	@user.password = @user.password_confirmation =  "ciaociao"   	
   	assert_not @user.valid?   
  end

  test "password should contain at least one letter" do
   	@user.password = @user.password_confirmation =  "123456"   	
   	assert_not @user.valid?   
  end
end
