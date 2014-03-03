require 'spec_helper'

module Codebreaker
  describe Game do
    describe "#start" do
      it "sends a welcome message" do
	#setup
	output = double('output').as_null_object
	game = Game.new(output)

	#set expectations
	output.should_receive(:puts).with('Welcome to Codebreaker!')

	#call behavior
	game.start
      end

      it "prompts for the first guess" do
	#setup objects
	output = double('output').as_null_object
	game = Game.new(output)

	#setup expectations
	output.should_receive(:puts).with('Enter guess:')

	#call behavior
	game.start
      end
    end
  end
end
