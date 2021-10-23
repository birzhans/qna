module ApplicationHelper

  def vote_class(votable, user_id, kind)
    return if user_id.nil?

    if Vote.find_by(votable: votable, user_id: user_id, kind: kind)
      'active'
    end
  end
end
