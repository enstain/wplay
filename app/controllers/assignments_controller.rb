class AssignmentsController < ApplicationController
	def iterate
		@assignment = Assignment.find(params[:id])
		@assignment.progress+=1 if @assignment.progress < @assignment.quest.iterates
		@assignment.save
		redirect_to quest_path(@assignment.quest)
	end
end