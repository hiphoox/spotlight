class Spotlight
  attr_accessor :query, :predicate
  
  def initialize
    @query = NSMetadataQuery.new
  end
  
  def search_in_file_type(file_type)
    stop
    predicate_format = "(kMDItemTextContent like[ci] '#{@predicate}') AND (kMDItemContentType == '#{file_type}')"
    puts predicate_format
    predicate_to_run = NSPredicate.predicateWithFormat(predicate_format)
    @query.setPredicate(predicate_to_run)
    @query.startQuery()
  end

  def stop
    @query.stopQuery()
  end
  
  def register_for_notifications(aDelegate, methodName)
    NSNotificationCenter.defaultCenter.addObserver aDelegate,
                                         selector: methodName,
                                             name: NSMetadataQueryDidFinishGatheringNotification, 
                                           object: @query
  end
  
  def remove_from_notifications(aDelegate)
    NSNotificationCenter.defaultCenter.removeObserver aDelegate,
                                                name: NSMetadataQueryDidFinishGatheringNotification,
                                              object: nil
  end
  
end