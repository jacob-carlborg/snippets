module PunditViewHelper
  # Stubs a Pundit policy in the view this module is included in.
  #
  # Use this when writing specs for views that use Pundit, i.e. the `policy`
  # method.
  #
  # @example
  #   # in the view
  #   if policy(:foo).edit?
  #   end
  #
  #   # in the spec
  #   stub_policy(action: :edit?, authorized: true)
  #
  # @param action [Symbol] the action to check if the subject is authorized to
  #   perform
  #
  # @param authorized [Boolean] indicates if the subject is authorized to
  #   perform the action
  def stub_policy(action:, authorized:)
    policy = double(:policy)
    allow(policy).to receive(action).and_return(authorized)

    without_partial_double_verification do
      allow(view).to receive(:policy).and_return(policy)
    end
  end
end
