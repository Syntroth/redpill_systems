require 'wcnh'

module Comms
  R = PennJSON::Remote
  MAX_HANDLES = 10

  def self.handle_list
    c = Comlink.find_or_create_by(id: R["enactor"])
    ret = titlebar("Comm Handles For #{R.penn_name(R["enactor"])}") + "\n"
    c.handles.each do |handle|
      ret << "  #{handle.bold.cyan}\n"
    end
    ret << "  You are using #{c.handles.length.to_s.bold.yellow} of your #{MAX_HANDLES.to_s.bold} allowed handles.\n"
    ret << "  Your active handle, used on all outbound private messages, is: #{c.active_handle.bold.yellow}\n"
    ret << footerbar
  end

  def self.handle_register(handle)
    return "> ".bold.yellow + "That handle is already in use." unless Comlink.where(lowercase_handles: handle.downcase).length == 0
    return "> ".bold.yellow + "That's too long for a handle." unless handle.length <= 20

    c = Comlink.find_or_create_by(id: R["enactor"])
    c.handles.push handle
    c.lowercase_handles.push handle.downcase
    c.save
    return "> ".bold.yellow + "Registered handle: #{handle.bold}."
  end

  def self.handle_unregister(handle)
    c = Comlink.find_or_create_by(id: R["enactor"])
    return "> ".bold.yellow + "That handle isn't registered, or isn't registered to you." unless c.lowercase_handles.include?(handle.downcase)
    return "> ".bold.yellow + "You can't unregister your active handle!" unless c.active_handle.downcase != handle.downcase
    return "> ".bold.yellow + "You must always have at least one handle registered." unless c.lowercase_handles.length > 1

    # find it in our lowercased array, then delete that position from the main array.
    i = c.lowercase_handles.find_index(handle.downcase)
    h = c.handles[i] # for the return string only.
    c.handles.slice!(i)
    c.lowercase_handles.slice!(i)
    c.save
    return "> ".bold.yellow + "Unregistered handle: #{h.bold}."
  end

  def self.handle_use(handle)
    c = Comlink.find_or_create_by(id: R["enactor"])
    return "> ".bold.yellow + "That handle isn't registered, or isn't registered to you." unless c.lowercase_handles.include?(handle.downcase)
    return "> ".bold.yellow + "That's already your active handle!" unless c.active_handle.downcase != handle.downcase

    # find using lowercased array to help with case matching.
    i = c.lowercase_handles.find_index(handle.downcase)
    c.active_handle = c.handles[i]
    c.save

    return "> ".bold.yellow + "Active handle set to #{c.handles[i].bold}."
  end
end