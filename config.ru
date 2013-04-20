$: << File.expand_path(File.join(__FILE__, ".."))

require 'app'

use API::Authenticate

run API::Rushour
