class ChangeParticipantInstructionsAndThankYouMessageDefaultsOnCardSorts < ActiveRecord::Migration[6.0]
  def change
    change_column_default :card_sorts, :participant_instructions, "Thank you for agreeing to help us! This shouldn't take more than 5 minutes.\n\nThere are no right or wrong answers. Our goal is to learn how you think about, organize and label certain topics into groups."
    change_column_default :card_sorts, :thank_you_message, "Thanks for taking the time to help us!\n\nYour feedback is essential for us to deliver ongoing improvements."
  end
end
