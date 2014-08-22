=begin
    Copyright 2010-2014 Tasos Laskos <tasos.laskos@gmail.com>
    Please see the LICENSE file at the root directory of the project.
=end

module Arachni::OptionGroups

# Holds login options for the {Arachni::Framework}'s {Arachni::Session} manager.
#
# @author Tasos "Zapotek" Laskos <tasos.laskos@gmail.com>
class Session < Arachni::OptionGroup

    # @return   [String]
    #   URL whose {Arachni::HTTP::Response response} {Arachni::HTTP::Response#body}
    #   should match {#check_pattern} when a valid webapp {Arachni::Session session}
    #   has been established.
    #
    # @see Session
    attr_accessor :check_url

    # @return   [Regexp]
    #   Pattern which should match the {#check_url} {Arachni::HTTP::Response response}
    #   {Arachni::HTTP::Response#body} when a valid webapp {Session session} has
    #   been established.
    #
    # @see Session
    attr_accessor :check_pattern

    def check_pattern=( pattern )
        return @check_pattern = nil if !pattern

        @check_pattern = Regexp.new( pattern )
    end

    def validate
        return {} if (check_url && check_pattern) || (!check_url && !check_pattern)

        {
            (check_url ? :check_pattern : :check_url) =>
                'Option is missing.'
        }
    end

    def to_rpc_data
        d = super
        d['check_pattern'] = d['check_pattern'].to_s if d['check_pattern']
        d
    end

end
end