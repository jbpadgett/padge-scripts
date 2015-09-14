require 'infoblox'
require 'csv'
#require 'resolv'


module Ipam
  class IpamConnection
    @@connection = Infoblox::Connection.new(:username => 'username', :password => 'password', :host => 'https://infoblox.example.com/wapi/v1.2.1')
  
    def self.myconnection
      @@connection
    end
    
    def myconnection
      @@Connection
    end
  end  
    
  class IpamSearch 
    attr_accessor :find_object  
    def initialize(find_object)
      @find_object = find_object
    end 
  
    def hostSearch 
      hsearch = Infoblox::Host.find(IpamConnection.myconnection, {"name~" => @find_object})
      hsearch.each do |myhostobject|
        h_name = myhostobject.name(&:name)
        h_ips = myhostobject.ipv4addrs.map(&:ipv4addr).join(",")
        h_aliases = myhostobject.aliases(&:alias)        
      if "#{h_name}" != nil
        puts "hostname => #{h_name}"
        puts "alias => #{h_aliases}"
        puts "ip address => #{h_ips}"
      else
        puts "No host found with the name #{@find_object}"
      end
      end  
    end

    def arecordSearch 
      asearch = Infoblox::Arecord.find(IpamConnection.myconnection, {"name~" => @find_object})
      asearch.each do |myhostobject|
        a_name = myhostobject.name(&:name)
        a_ip = myhostobject.ipv4addr(&:ipv4addr)
        puts "arecord => #{a_name}"
        puts "ip address => #{a_ip}"
      end
    end
    
    def cnameSearch
      csearch = Infoblox::Cname.find(IpamConnection.myconnection, {"name~" => @find_object})
      csearch.each do |myhostobject|
        a_name = myhostobject.name(&:name)
        c_name = myhostobject.canonical(&:canonical)
        a_ip = myhostobject.ipv4addr(&:ipv4addr)
        puts "hostname => #{a_name}"
        puts "cname => #{c_name}"                
      end
    end
    
    def ipv4Search
      ipsearch = Infoblox::HostIpv4addr.find(IpamConnection.myconnection, {"ipv4addr" => @find_object})
      ipsearch.each do |myhostobject|
        h_name = myhostobject.name(&:host)
        a_ip = myhostobject.ipv4addr(&:ipv4addr)
        m_name = myhostobject.mac(&:mac)
        puts "hostname => #{h_name}"
        puts "ip address => #{a_ip}"          
        puts "mac address => #{m_name}"                
      end        
    end
 
    def gridSearch
      gsearch = Infoblox::Search.find(IpamConnection.myconnection, {"search_string~" => @find_object})
    end  
  end    




  # To get the next IP you must first search a given network by its object name. Finding the object name can be done by logical environment name.
  # Logical environment names, to be searched, will be added as extensible attributes (EA) to network objects as: VLAN, or Environment
  # Ex) @mynetworkobject = tdev  @mynetworkobject = 1200
  class IpamGetip
    attr_accessor :mynetworkobject
    def initialize(mynetworkobject)
      @mynetworkobject = mynetworkobject
    end
    
    def findNetbyEAenv
      netobjname = Infoblox::Network.find(IpamConnection.myconnection, {"_return_fields" => "extensible_attributes", "*Environment" => @mynetworkobject})
    end
 
    def findNetbyEAfwzone
      netobjname = Infoblox::Network.find(IpamConnection.myconnection, {"_return_fields" => "extensible_attributes", "*FW_ZONE" => @mynetworkobject})
    end
    
    def findNetbyEAvlan
      netobjname = Infoblox::Network.find(IpamConnection.myconnection, {"_return_fields" => "extensible_attributes", "*VLAN" => @mynetworkobject})
    end
    
    def findNetobj  
      netobjname = Infoblox::Network.find(IpamConnection.myconnection, {"network~" => @mynetworkobject})
    end
    
    def nextIPget
      nipsearch = Infoblox::Network.network(IpamConnection.myconnection, {"network~" => @mynetworkobject})      
    end
  
  end



  # Add records
  class IpamAddrecord
      attr_accessor :foo1, :bar1, :baz1
      def initialize(foo1, bar1, baz1)
        @foo1 = foo1
        @bar1 = bar1
        @baz1 = baz1
      end
      
      def hostAdd
        puts "host"
      end
      
      def cnameAdd
        puts "cname"
      end
      
    end  
 

# Mass import multiple new records at once   
#    class IpamCsvimport
#      csv_import = CSV.read('ipam.csv')
#      CSV.foreach('ipam.csv') do |row|
#        puts row.inspect
#      end
#    end
 

end




#####################
# TESTING 
#####################

# Search by type
#HSearch = Ipam::IpamSearch.new("10.10.10.10").gridSearch
#puts HSearch
# puts "The Grid Search is complete."

# Search by host
HSearch = Ipam::IpamSearch.new("mynodetest1.example.com").hostSearch
puts "The host Search is complete."

# Search by arecord
#ASearch = Ipam::IpamSearch.new("mynodetest1.example.com").arecordSearch
#puts "The A Record Search is complete."

# Search by CName
#CSearch = Ipam::IpamSearch.new("mynodetest1.example.com").cnameSearch
#puts "The CName Search is complete."

# Search by host IP address
IPV4Search = Ipam::IpamSearch.new("10.10.10.10").ipv4Search
puts IPV4Search
puts "The IPv4 Search is complete."






# Find network object name
#NSearch = Ipam::IpamGetip.new("10.10.10.0").findNetobj
#puts NSearch

# Find network object name by extensible attributes environment
#NSearch2 = Ipam::IpamGetip.new("mycloud").findNetbyEAenv
#puts NSearch2

# Find network object name by extensible attributes environment
#NSearch3 = Ipam::IpamGetip.new("dev").findNetbyEAfwzone
#puts NSearch3


# Find network object name by extensible attributes vlan
#NSearch = Ipam::IpamGetip.new("1010").findNetbyEAvlan
#puts NSearch


