# frozen_string_literal: true

class BaseForm
  def initialize(attributes)
    @attributes = attributes
  end

  def invalid?
    content.invalid?
  end

  def save
    before_validation
    return false if invalid?

    after_validation
    save!
  end

  def save!
    ActiveRecord::Base.transaction do
      before_save
      content.save!
      after_save
    end

    after_commit
    content
  end

  def errors
    content.errors
  end

  private

  attr_reader :attributes, :content

  def before_validation; end

  def before_save; end

  def after_validation; end

  def after_save; end

  def after_commit; end
end
