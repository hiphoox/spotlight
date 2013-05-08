class AppDelegate
  attr_accessor :spotlight, :fileView, :mdItemController, :metaDataView

  def initialize
    @spotlight = Spotlight.new
    #Setting a default search value
    @spotlight.predicate = "RubyMotion"
  end

  def awakeFromNib
    #CGPoint.new
    #CGRect.new
    @metaDataView.setBackgroundColor(NSColor.lightGrayColor)
    @spotlight.register_for_notifications(self, 'updateSearching:')
    NSNotificationCenter.defaultCenter.addObserver self,
                                         selector: 'updateSearching:',
                                             name: NSTableViewSelectionDidChangeNotification, 
                                           object: @fileView
  end

  #Notification and Event Handlers    
  def updateSearching(sender)
    info = ''
    @mdItemController.selectedObjects.to_a.each do |item| 
      item.attributes.to_a.each do |attr_name|
        info += "#{attr_name} = #{item.valueForAttribute(attr_name).to_s} \n"
      end
    end
    @metaDataView.setString(info) 
  end

  def search(sender)
    @spotlight.search_in_file_type('public.ruby-script')
  end
    
  def applicationWillTerminate(notification)
    @spotlight.remove_from_notifications(self)
    NSNotificationCenter.defaultCenter.removeObserver self,
                                                name: NSTableViewSelectionDidChangeNotification,
                                              object: nil
  end

end
