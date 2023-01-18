module WindowsError

  # This module provides the namespace for all of the HRESULT Error Codes.
  # See [HRESULT](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-erref/0642cb2f-2075-4469-918c-4441e69c548a)
  # for more details on this particular set of error codes.
  module HResult

    require 'windows_error/h_result/facility'

    # Returns all the {HResultCode} objects that match
    # the return value supplied.
    #
    # @param [Integer] retval the return value you want the error code for
    # @raise [ArgumentError] if something other than a Integer is supplied
    # @return [Array<HResultCode>] all Win32 ErrorCodes that matched
    def self.find_by_retval(retval)
      raise ArgumentError, "Invalid value!" unless retval.kind_of? Integer
      error_codes = []
      self.constants.sort.each do |constant_name|
        error_code = self.const_get(constant_name)
        if error_code == retval
          error_codes << error_code
        end
      end
      error_codes
    end

    # This class extends the ErrorCode with additional HRESULT-specific
    # attributes.
    class HResultCode < WindowsError::ErrorCode
      # @return [Integer] The error code.
      def code
        value & 0xffff
      end

      # @return [Boolean] Whether or not the value is customer-defined.
      def customer?
        value >> 29 == 1
      end

      # @return [Facility::FacilityCode] The source of the error.
      def facility
        Facility.find_by_code(value >> 16 & 0b11111)
      end

      # @return [Boolean] Whether or not the value indicates a failure.
      def failure?
        value >> 31 == 1
      end

      # @return [Boolean] Whether or not the value indicates a succcess.
      def success?
        !failure?
      end
    end

    #
    # CONSTANTS
    #

    # (0x00030200) The underlying file was converted to compound file format.
    STG_S_CONVERTED = HResultCode.new('STG_S_CONVERTED', 0x00030200, 'The underlying file was converted to compound file format.')

    # (0x00030201) The storage operation should block until more data is available.
    STG_S_BLOCK = HResultCode.new('STG_S_BLOCK', 0x00030201, 'The storage operation should block until more data is available.')

    # (0x00030202) The storage operation should retry immediately.
    STG_S_RETRYNOW = HResultCode.new('STG_S_RETRYNOW', 0x00030202, 'The storage operation should retry immediately.')

    # (0x00030203) The notified event sink will not influence the storage operation.
    STG_S_MONITORING = HResultCode.new('STG_S_MONITORING', 0x00030203, 'The notified event sink will not influence the storage operation.')

    # (0x00030204) Multiple opens prevent consolidated (commit succeeded).
    STG_S_MULTIPLEOPENS = HResultCode.new('STG_S_MULTIPLEOPENS', 0x00030204, 'Multiple opens prevent consolidated (commit succeeded).')

    # (0x00030205) Consolidation of the storage file failed (commit succeeded).
    STG_S_CONSOLIDATIONFAILED = HResultCode.new('STG_S_CONSOLIDATIONFAILED', 0x00030205, 'Consolidation of the storage file failed (commit succeeded).')

    # (0x00030206) Consolidation of the storage file is inappropriate (commit succeeded).
    STG_S_CANNOTCONSOLIDATE = HResultCode.new('STG_S_CANNOTCONSOLIDATE', 0x00030206, 'Consolidation of the storage file is inappropriate (commit succeeded).')

    # (0x00040000) Use the registry database to provide the requested information.
    OLE_S_USEREG = HResultCode.new('OLE_S_USEREG', 0x00040000, 'Use the registry database to provide the requested information.')

    # (0x00040001) Success, but static.
    OLE_S_STATIC = HResultCode.new('OLE_S_STATIC', 0x00040001, 'Success, but static.')

    # (0x00040002) Macintosh clipboard format.
    OLE_S_MAC_CLIPFORMAT = HResultCode.new('OLE_S_MAC_CLIPFORMAT', 0x00040002, 'Macintosh clipboard format.')

    # (0x00040100) Successful drop took place.
    DRAGDROP_S_DROP = HResultCode.new('DRAGDROP_S_DROP', 0x00040100, 'Successful drop took place.')

    # (0x00040101) Drag-drop operation canceled.
    DRAGDROP_S_CANCEL = HResultCode.new('DRAGDROP_S_CANCEL', 0x00040101, 'Drag-drop operation canceled.')

    # (0x00040102) Use the default cursor.
    DRAGDROP_S_USEDEFAULTCURSORS = HResultCode.new('DRAGDROP_S_USEDEFAULTCURSORS', 0x00040102, 'Use the default cursor.')

    # (0x00040130) Data has same FORMATETC.
    DATA_S_SAMEFORMATETC = HResultCode.new('DATA_S_SAMEFORMATETC', 0x00040130, 'Data has same FORMATETC.')

    # (0x00040140) View is already frozen.
    VIEW_S_ALREADY_FROZEN = HResultCode.new('VIEW_S_ALREADY_FROZEN', 0x00040140, 'View is already frozen.')

    # (0x00040170) FORMATETC not supported.
    CACHE_S_FORMATETC_NOTSUPPORTED = HResultCode.new('CACHE_S_FORMATETC_NOTSUPPORTED', 0x00040170, 'FORMATETC not supported.')

    # (0x00040171) Same cache.
    CACHE_S_SAMECACHE = HResultCode.new('CACHE_S_SAMECACHE', 0x00040171, 'Same cache.')

    # (0x00040172) Some caches are not updated.
    CACHE_S_SOMECACHES_NOTUPDATED = HResultCode.new('CACHE_S_SOMECACHES_NOTUPDATED', 0x00040172, 'Some caches are not updated.')

    # (0x00040180) Invalid verb for OLE object.
    OLEOBJ_S_INVALIDVERB = HResultCode.new('OLEOBJ_S_INVALIDVERB', 0x00040180, 'Invalid verb for OLE object.')

    # (0x00040181) Verb number is valid but verb cannot be done now.
    OLEOBJ_S_CANNOT_DOVERB_NOW = HResultCode.new('OLEOBJ_S_CANNOT_DOVERB_NOW', 0x00040181, 'Verb number is valid but verb cannot be done now.')

    # (0x00040182) Invalid window handle passed.
    OLEOBJ_S_INVALIDHWND = HResultCode.new('OLEOBJ_S_INVALIDHWND', 0x00040182, 'Invalid window handle passed.')

    # (0x000401a0) Message is too long; some of it had to be truncated before displaying.
    INPLACE_S_TRUNCATED = HResultCode.new('INPLACE_S_TRUNCATED', 0x000401a0, 'Message is too long; some of it had to be truncated before displaying.')

    # (0x000401c0) Unable to convert OLESTREAM to IStorage.
    CONVERT10_S_NO_PRESENTATION = HResultCode.new('CONVERT10_S_NO_PRESENTATION', 0x000401c0, 'Unable to convert OLESTREAM to IStorage.')

    # (0x000401e2) Moniker reduced to itself.
    MK_S_REDUCED_TO_SELF = HResultCode.new('MK_S_REDUCED_TO_SELF', 0x000401e2, 'Moniker reduced to itself.')

    # (0x000401e4) Common prefix is this moniker.
    MK_S_ME = HResultCode.new('MK_S_ME', 0x000401e4, 'Common prefix is this moniker.')

    # (0x000401e5) Common prefix is input moniker.
    MK_S_HIM = HResultCode.new('MK_S_HIM', 0x000401e5, 'Common prefix is input moniker.')

    # (0x000401e6) Common prefix is both monikers.
    MK_S_US = HResultCode.new('MK_S_US', 0x000401e6, 'Common prefix is both monikers.')

    # (0x000401e7) Moniker is already registered in running object table.
    MK_S_MONIKERALREADYREGISTERED = HResultCode.new('MK_S_MONIKERALREADYREGISTERED', 0x000401e7, 'Moniker is already registered in running object table.')

    # (0x00040200) An event was able to invoke some, but not all, of the subscribers.
    EVENT_S_SOME_SUBSCRIBERS_FAILED = HResultCode.new('EVENT_S_SOME_SUBSCRIBERS_FAILED', 0x00040200, 'An event was able to invoke some, but not all, of the subscribers.')

    # (0x00040202) An event was delivered, but there were no subscribers.
    EVENT_S_NOSUBSCRIBERS = HResultCode.new('EVENT_S_NOSUBSCRIBERS', 0x00040202, 'An event was delivered, but there were no subscribers.')

    # (0x00041300) The task is ready to run at its next scheduled time.
    SCHED_S_TASK_READY = HResultCode.new('SCHED_S_TASK_READY', 0x00041300, 'The task is ready to run at its next scheduled time.')

    # (0x00041301) The task is currently running.
    SCHED_S_TASK_RUNNING = HResultCode.new('SCHED_S_TASK_RUNNING', 0x00041301, 'The task is currently running.')

    # (0x00041302) The task will not run at the scheduled times because it has been disabled.
    SCHED_S_TASK_DISABLED = HResultCode.new('SCHED_S_TASK_DISABLED', 0x00041302, 'The task will not run at the scheduled times because it has been disabled.')

    # (0x00041303) The task has not yet run.
    SCHED_S_TASK_HAS_NOT_RUN = HResultCode.new('SCHED_S_TASK_HAS_NOT_RUN', 0x00041303, 'The task has not yet run.')

    # (0x00041304) There are no more runs scheduled for this task.
    SCHED_S_TASK_NO_MORE_RUNS = HResultCode.new('SCHED_S_TASK_NO_MORE_RUNS', 0x00041304, 'There are no more runs scheduled for this task.')

    # (0x00041305) One or more of the properties that are needed to run this task on a schedule have not been set.
    SCHED_S_TASK_NOT_SCHEDULED = HResultCode.new('SCHED_S_TASK_NOT_SCHEDULED', 0x00041305, 'One or more of the properties that are needed to run this task on a schedule have not been set.')

    # (0x00041306) The last run of the task was terminated by the user.
    SCHED_S_TASK_TERMINATED = HResultCode.new('SCHED_S_TASK_TERMINATED', 0x00041306, 'The last run of the task was terminated by the user.')

    # (0x00041307) Either the task has no triggers, or the existing triggers are disabled or not set.
    SCHED_S_TASK_NO_VALID_TRIGGERS = HResultCode.new('SCHED_S_TASK_NO_VALID_TRIGGERS', 0x00041307, 'Either the task has no triggers, or the existing triggers are disabled or not set.')

    # (0x00041308) Event triggers do not have set run times.
    SCHED_S_EVENT_TRIGGER = HResultCode.new('SCHED_S_EVENT_TRIGGER', 0x00041308, 'Event triggers do not have set run times.')

    # (0x0004131b) The task is registered, but not all specified triggers will start the task.
    SCHED_S_SOME_TRIGGERS_FAILED = HResultCode.new('SCHED_S_SOME_TRIGGERS_FAILED', 0x0004131b, 'The task is registered, but not all specified triggers will start the task.')

    # (0x0004131c) The task is registered, but it might fail to start. Batch logon privilege needs to be enabled for the task principal.
    SCHED_S_BATCH_LOGON_PROBLEM = HResultCode.new('SCHED_S_BATCH_LOGON_PROBLEM', 0x0004131c, 'The task is registered, but it might fail to start. Batch logon privilege needs to be enabled for the task principal.')

    # (0x0004d000) An asynchronous operation was specified. The operation has begun, but its outcome is not known yet.
    XACT_S_ASYNC = HResultCode.new('XACT_S_ASYNC', 0x0004d000, 'An asynchronous operation was specified. The operation has begun, but its outcome is not known yet.')

    # (0x0004d002) The method call succeeded because the transaction was read-only.
    XACT_S_READONLY = HResultCode.new('XACT_S_READONLY', 0x0004d002, 'The method call succeeded because the transaction was read-only.')

    # (0x0004d003) The transaction was successfully aborted. However, this is a coordinated transaction, and a number of enlisted resources were aborted outright because they could not support abort-retaining semantics.
    XACT_S_SOMENORETAIN = HResultCode.new('XACT_S_SOMENORETAIN', 0x0004d003, 'The transaction was successfully aborted. However, this is a coordinated transaction, and a number of enlisted resources were aborted outright because they could not support abort-retaining semantics.')

    # (0x0004d004) No changes were made during this call, but the sink wants another chance to look if any other sinks make further changes.
    XACT_S_OKINFORM = HResultCode.new('XACT_S_OKINFORM', 0x0004d004, 'No changes were made during this call, but the sink wants another chance to look if any other sinks make further changes.')

    # (0x0004d005) The sink is content and wants the transaction to proceed. Changes were made to one or more resources during this call.
    XACT_S_MADECHANGESCONTENT = HResultCode.new('XACT_S_MADECHANGESCONTENT', 0x0004d005, 'The sink is content and wants the transaction to proceed. Changes were made to one or more resources during this call.')

    # (0x0004d006) The sink is for the moment and wants the transaction to proceed, but if other changes are made following this return by other event sinks, this sink wants another chance to look.
    XACT_S_MADECHANGESINFORM = HResultCode.new('XACT_S_MADECHANGESINFORM', 0x0004d006, 'The sink is for the moment and wants the transaction to proceed, but if other changes are made following this return by other event sinks, this sink wants another chance to look.')

    # (0x0004d007) The transaction was successfully aborted. However, the abort was nonretaining.
    XACT_S_ALLNORETAIN = HResultCode.new('XACT_S_ALLNORETAIN', 0x0004d007, 'The transaction was successfully aborted. However, the abort was nonretaining.')

    # (0x0004d008) An abort operation was already in progress.
    XACT_S_ABORTING = HResultCode.new('XACT_S_ABORTING', 0x0004d008, 'An abort operation was already in progress.')

    # (0x0004d009) The resource manager has performed a single-phase commit of the transaction.
    XACT_S_SINGLEPHASE = HResultCode.new('XACT_S_SINGLEPHASE', 0x0004d009, 'The resource manager has performed a single-phase commit of the transaction.')

    # (0x0004d00a) The local transaction has not aborted.
    XACT_S_LOCALLY_OK = HResultCode.new('XACT_S_LOCALLY_OK', 0x0004d00a, 'The local transaction has not aborted.')

    # (0x0004d010) The resource manager has requested to be the coordinator (last resource manager) for the transaction.
    XACT_S_LASTRESOURCEMANAGER = HResultCode.new('XACT_S_LASTRESOURCEMANAGER', 0x0004d010, 'The resource manager has requested to be the coordinator (last resource manager) for the transaction.')

    # (0x00080012) Not all the requested interfaces were available.
    CO_S_NOTALLINTERFACES = HResultCode.new('CO_S_NOTALLINTERFACES', 0x00080012, 'Not all the requested interfaces were available.')

    # (0x00080013) The specified machine name was not found in the cache.
    CO_S_MACHINENAMENOTFOUND = HResultCode.new('CO_S_MACHINENAMENOTFOUND', 0x00080013, 'The specified machine name was not found in the cache.')

    # (0x00090312) The function completed successfully, but it must be called again to complete the context.
    SEC_I_CONTINUE_NEEDED = HResultCode.new('SEC_I_CONTINUE_NEEDED', 0x00090312, 'The function completed successfully, but it must be called again to complete the context.')

    # (0x00090313) The function completed successfully, but CompleteToken must be called.
    SEC_I_COMPLETE_NEEDED = HResultCode.new('SEC_I_COMPLETE_NEEDED', 0x00090313, 'The function completed successfully, but CompleteToken must be called.')

    # (0x00090314) The function completed successfully, but both CompleteToken and this function must be called to complete the context.
    SEC_I_COMPLETE_AND_CONTINUE = HResultCode.new('SEC_I_COMPLETE_AND_CONTINUE', 0x00090314, 'The function completed successfully, but both CompleteToken and this function must be called to complete the context.')

    # (0x00090315) The logon was completed, but no network authority was available. The logon was made using locally known information.
    SEC_I_LOCAL_LOGON = HResultCode.new('SEC_I_LOCAL_LOGON', 0x00090315, 'The logon was completed, but no network authority was available. The logon was made using locally known information.')

    # (0x00090317) The context has expired and can no longer be used.
    SEC_I_CONTEXT_EXPIRED = HResultCode.new('SEC_I_CONTEXT_EXPIRED', 0x00090317, 'The context has expired and can no longer be used.')

    # (0x00090320) The credentials supplied were not complete and could not be verified. Additional information can be returned from the context.
    SEC_I_INCOMPLETE_CREDENTIALS = HResultCode.new('SEC_I_INCOMPLETE_CREDENTIALS', 0x00090320, 'The credentials supplied were not complete and could not be verified. Additional information can be returned from the context.')

    # (0x00090321) The context data must be renegotiated with the peer.
    SEC_I_RENEGOTIATE = HResultCode.new('SEC_I_RENEGOTIATE', 0x00090321, 'The context data must be renegotiated with the peer.')

    # (0x00090323) There is no LSA mode context associated with this context.
    SEC_I_NO_LSA_CONTEXT = HResultCode.new('SEC_I_NO_LSA_CONTEXT', 0x00090323, 'There is no LSA mode context associated with this context.')

    # (0x0009035c) A signature operation must be performed before the user can authenticate.
    SEC_I_SIGNATURE_NEEDED = HResultCode.new('SEC_I_SIGNATURE_NEEDED', 0x0009035c, 'A signature operation must be performed before the user can authenticate.')

    # (0x00091012) The protected data needs to be reprotected.
    CRYPT_I_NEW_PROTECTION_REQUIRED = HResultCode.new('CRYPT_I_NEW_PROTECTION_REQUIRED', 0x00091012, 'The protected data needs to be reprotected.')

    # (0x000d0000) The requested operation is pending completion.
    NS_S_CALLPENDING = HResultCode.new('NS_S_CALLPENDING', 0x000d0000, 'The requested operation is pending completion.')

    # (0x000d0001) The requested operation was aborted by the client.
    NS_S_CALLABORTED = HResultCode.new('NS_S_CALLABORTED', 0x000d0001, 'The requested operation was aborted by the client.')

    # (0x000d0002) The stream was purposefully stopped before completion.
    NS_S_STREAM_TRUNCATED = HResultCode.new('NS_S_STREAM_TRUNCATED', 0x000d0002, 'The stream was purposefully stopped before completion.')

    # (0x000d0bc8) The requested operation has caused the source to rebuffer.
    NS_S_REBUFFERING = HResultCode.new('NS_S_REBUFFERING', 0x000d0bc8, 'The requested operation has caused the source to rebuffer.')

    # (0x000d0bc9) The requested operation has caused the source to degrade codec quality.
    NS_S_DEGRADING_QUALITY = HResultCode.new('NS_S_DEGRADING_QUALITY', 0x000d0bc9, 'The requested operation has caused the source to degrade codec quality.')

    # (0x000d0bdb) The transcryptor object has reached end of file.
    NS_S_TRANSCRYPTOR_EOF = HResultCode.new('NS_S_TRANSCRYPTOR_EOF', 0x000d0bdb, 'The transcryptor object has reached end of file.')

    # (0x000d0fe8) An upgrade is needed for the theme manager to correctly show this skin. Skin reports version: %.1f.
    NS_S_WMP_UI_VERSIONMISMATCH = HResultCode.new('NS_S_WMP_UI_VERSIONMISMATCH', 0x000d0fe8, 'An upgrade is needed for the theme manager to correctly show this skin. Skin reports version: %.1f.')

    # (0x000d0fe9) An error occurred in one of the UI components.
    NS_S_WMP_EXCEPTION = HResultCode.new('NS_S_WMP_EXCEPTION', 0x000d0fe9, 'An error occurred in one of the UI components.')

    # (0x000d1040) Successfully loaded a GIF file.
    NS_S_WMP_LOADED_GIF_IMAGE = HResultCode.new('NS_S_WMP_LOADED_GIF_IMAGE', 0x000d1040, 'Successfully loaded a GIF file.')

    # (0x000d1041) Successfully loaded a PNG file.
    NS_S_WMP_LOADED_PNG_IMAGE = HResultCode.new('NS_S_WMP_LOADED_PNG_IMAGE', 0x000d1041, 'Successfully loaded a PNG file.')

    # (0x000d1042) Successfully loaded a BMP file.
    NS_S_WMP_LOADED_BMP_IMAGE = HResultCode.new('NS_S_WMP_LOADED_BMP_IMAGE', 0x000d1042, 'Successfully loaded a BMP file.')

    # (0x000d1043) Successfully loaded a JPG file.
    NS_S_WMP_LOADED_JPG_IMAGE = HResultCode.new('NS_S_WMP_LOADED_JPG_IMAGE', 0x000d1043, 'Successfully loaded a JPG file.')

    # (0x000d104f) Drop this frame.
    NS_S_WMG_FORCE_DROP_FRAME = HResultCode.new('NS_S_WMG_FORCE_DROP_FRAME', 0x000d104f, 'Drop this frame.')

    # (0x000d105f) The specified stream has already been rendered.
    NS_S_WMR_ALREADYRENDERED = HResultCode.new('NS_S_WMR_ALREADYRENDERED', 0x000d105f, 'The specified stream has already been rendered.')

    # (0x000d1060) The specified type partially matches this pin type.
    NS_S_WMR_PINTYPEPARTIALMATCH = HResultCode.new('NS_S_WMR_PINTYPEPARTIALMATCH', 0x000d1060, 'The specified type partially matches this pin type.')

    # (0x000d1061) The specified type fully matches this pin type.
    NS_S_WMR_PINTYPEFULLMATCH = HResultCode.new('NS_S_WMR_PINTYPEFULLMATCH', 0x000d1061, 'The specified type fully matches this pin type.')

    # (0x000d1066) The timestamp is late compared to the current render position. Advise dropping this frame.
    NS_S_WMG_ADVISE_DROP_FRAME = HResultCode.new('NS_S_WMG_ADVISE_DROP_FRAME', 0x000d1066, 'The timestamp is late compared to the current render position. Advise dropping this frame.')

    # (0x000d1067) The timestamp is severely late compared to the current render position. Advise dropping everything up to the next key frame.
    NS_S_WMG_ADVISE_DROP_TO_KEYFRAME = HResultCode.new('NS_S_WMG_ADVISE_DROP_TO_KEYFRAME', 0x000d1067, 'The timestamp is severely late compared to the current render position. Advise dropping everything up to the next key frame.')

    # (0x000d10db) No burn rights. You will be prompted to buy burn rights when you try to burn this file to an audio CD.
    NS_S_NEED_TO_BUY_BURN_RIGHTS = HResultCode.new('NS_S_NEED_TO_BUY_BURN_RIGHTS', 0x000d10db, 'No burn rights. You will be prompted to buy burn rights when you try to burn this file to an audio CD.')

    # (0x000d10fe) Failed to clear playlist because it was aborted by user.
    NS_S_WMPCORE_PLAYLISTCLEARABORT = HResultCode.new('NS_S_WMPCORE_PLAYLISTCLEARABORT', 0x000d10fe, 'Failed to clear playlist because it was aborted by user.')

    # (0x000d10ff) Failed to remove item in the playlist since it was aborted by user.
    NS_S_WMPCORE_PLAYLISTREMOVEITEMABORT = HResultCode.new('NS_S_WMPCORE_PLAYLISTREMOVEITEMABORT', 0x000d10ff, 'Failed to remove item in the playlist since it was aborted by user.')

    # (0x000d1102) Playlist is being generated asynchronously.
    NS_S_WMPCORE_PLAYLIST_CREATION_PENDING = HResultCode.new('NS_S_WMPCORE_PLAYLIST_CREATION_PENDING', 0x000d1102, 'Playlist is being generated asynchronously.')

    # (0x000d1103) Validation of the media is pending.
    NS_S_WMPCORE_MEDIA_VALIDATION_PENDING = HResultCode.new('NS_S_WMPCORE_MEDIA_VALIDATION_PENDING', 0x000d1103, 'Validation of the media is pending.')

    # (0x000d1104) Encountered more than one Repeat block during ASX processing.
    NS_S_WMPCORE_PLAYLIST_REPEAT_SECONDARY_SEGMENTS_IGNORED = HResultCode.new('NS_S_WMPCORE_PLAYLIST_REPEAT_SECONDARY_SEGMENTS_IGNORED', 0x000d1104, 'Encountered more than one Repeat block during ASX processing.')

    # (0x000d1105) Current state of WMP disallows calling this method or property.
    NS_S_WMPCORE_COMMAND_NOT_AVAILABLE = HResultCode.new('NS_S_WMPCORE_COMMAND_NOT_AVAILABLE', 0x000d1105, 'Current state of WMP disallows calling this method or property.')

    # (0x000d1106) Name for the playlist has been auto generated.
    NS_S_WMPCORE_PLAYLIST_NAME_AUTO_GENERATED = HResultCode.new('NS_S_WMPCORE_PLAYLIST_NAME_AUTO_GENERATED', 0x000d1106, 'Name for the playlist has been auto generated.')

    # (0x000d1107) The imported playlist does not contain all items from the original.
    NS_S_WMPCORE_PLAYLIST_IMPORT_MISSING_ITEMS = HResultCode.new('NS_S_WMPCORE_PLAYLIST_IMPORT_MISSING_ITEMS', 0x000d1107, 'The imported playlist does not contain all items from the original.')

    # (0x000d1108) The M3U playlist has been ignored because it only contains one item.
    NS_S_WMPCORE_PLAYLIST_COLLAPSED_TO_SINGLE_MEDIA = HResultCode.new('NS_S_WMPCORE_PLAYLIST_COLLAPSED_TO_SINGLE_MEDIA', 0x000d1108, 'The M3U playlist has been ignored because it only contains one item.')

    # (0x000d1109) The open for the child playlist associated with this media is pending.
    NS_S_WMPCORE_MEDIA_CHILD_PLAYLIST_OPEN_PENDING = HResultCode.new('NS_S_WMPCORE_MEDIA_CHILD_PLAYLIST_OPEN_PENDING', 0x000d1109, 'The open for the child playlist associated with this media is pending.')

    # (0x000d110a) More nodes support the interface requested, but the array for returning them is full.
    NS_S_WMPCORE_MORE_NODES_AVAIABLE = HResultCode.new('NS_S_WMPCORE_MORE_NODES_AVAIABLE', 0x000d110a, 'More nodes support the interface requested, but the array for returning them is full.')

    # (0x000d1135) Backup or Restore successful!.
    NS_S_WMPBR_SUCCESS = HResultCode.new('NS_S_WMPBR_SUCCESS', 0x000d1135, 'Backup or Restore successful!.')

    # (0x000d1136) Transfer complete with limitations.
    NS_S_WMPBR_PARTIALSUCCESS = HResultCode.new('NS_S_WMPBR_PARTIALSUCCESS', 0x000d1136, 'Transfer complete with limitations.')

    # (0x000d1144) Request to the effects control to change transparency status to transparent.
    NS_S_WMPEFFECT_TRANSPARENT = HResultCode.new('NS_S_WMPEFFECT_TRANSPARENT', 0x000d1144, 'Request to the effects control to change transparency status to transparent.')

    # (0x000d1145) Request to the effects control to change transparency status to opaque.
    NS_S_WMPEFFECT_OPAQUE = HResultCode.new('NS_S_WMPEFFECT_OPAQUE', 0x000d1145, 'Request to the effects control to change transparency status to opaque.')

    # (0x000d114e) The requested application pane is performing an operation and will not be released.
    NS_S_OPERATION_PENDING = HResultCode.new('NS_S_OPERATION_PENDING', 0x000d114e, 'The requested application pane is performing an operation and will not be released.')

    # (0x000d1359) The file is only available for purchase when you buy the entire album.
    NS_S_TRACK_BUY_REQUIRES_ALBUM_PURCHASE = HResultCode.new('NS_S_TRACK_BUY_REQUIRES_ALBUM_PURCHASE', 0x000d1359, 'The file is only available for purchase when you buy the entire album.')

    # (0x000d135e) There were problems completing the requested navigation. There are identifiers missing in the catalog.
    NS_S_NAVIGATION_COMPLETE_WITH_ERRORS = HResultCode.new('NS_S_NAVIGATION_COMPLETE_WITH_ERRORS', 0x000d135e, 'There were problems completing the requested navigation. There are identifiers missing in the catalog.')

    # (0x000d1361) Track already downloaded.
    NS_S_TRACK_ALREADY_DOWNLOADED = HResultCode.new('NS_S_TRACK_ALREADY_DOWNLOADED', 0x000d1361, 'Track already downloaded.')

    # (0x000d1519) The publishing point successfully started, but one or more of the requested data writer plug-ins failed.
    NS_S_PUBLISHING_POINT_STARTED_WITH_FAILED_SINKS = HResultCode.new('NS_S_PUBLISHING_POINT_STARTED_WITH_FAILED_SINKS', 0x000d1519, 'The publishing point successfully started, but one or more of the requested data writer plug-ins failed.')

    # (0x000d2726) Status message: The license was acquired.
    NS_S_DRM_LICENSE_ACQUIRED = HResultCode.new('NS_S_DRM_LICENSE_ACQUIRED', 0x000d2726, 'Status message: The license was acquired.')

    # (0x000d2727) Status message: The security upgrade has been completed.
    NS_S_DRM_INDIVIDUALIZED = HResultCode.new('NS_S_DRM_INDIVIDUALIZED', 0x000d2727, 'Status message: The security upgrade has been completed.')

    # (0x000d2746) Status message: License monitoring has been canceled.
    NS_S_DRM_MONITOR_CANCELLED = HResultCode.new('NS_S_DRM_MONITOR_CANCELLED', 0x000d2746, 'Status message: License monitoring has been canceled.')

    # (0x000d2747) Status message: License acquisition has been canceled.
    NS_S_DRM_ACQUIRE_CANCELLED = HResultCode.new('NS_S_DRM_ACQUIRE_CANCELLED', 0x000d2747, 'Status message: License acquisition has been canceled.')

    # (0x000d276e) The track is burnable and had no playlist burn limit.
    NS_S_DRM_BURNABLE_TRACK = HResultCode.new('NS_S_DRM_BURNABLE_TRACK', 0x000d276e, 'The track is burnable and had no playlist burn limit.')

    # (0x000d276f) The track is burnable but has a playlist burn limit.
    NS_S_DRM_BURNABLE_TRACK_WITH_PLAYLIST_RESTRICTION = HResultCode.new('NS_S_DRM_BURNABLE_TRACK_WITH_PLAYLIST_RESTRICTION', 0x000d276f, 'The track is burnable but has a playlist burn limit.')

    # (0x000d27de) A security upgrade is required to perform the operation on this media file.
    NS_S_DRM_NEEDS_INDIVIDUALIZATION = HResultCode.new('NS_S_DRM_NEEDS_INDIVIDUALIZATION', 0x000d27de, 'A security upgrade is required to perform the operation on this media file.')

    # (0x000d2af8) Installation was successful; however, some file cleanup is not complete. For best results, restart your computer.
    NS_S_REBOOT_RECOMMENDED = HResultCode.new('NS_S_REBOOT_RECOMMENDED', 0x000d2af8, 'Installation was successful; however, some file cleanup is not complete. For best results, restart your computer.')

    # (0x000d2af9) Installation was successful; however, some file cleanup is not complete. To continue, you must restart your computer.
    NS_S_REBOOT_REQUIRED = HResultCode.new('NS_S_REBOOT_REQUIRED', 0x000d2af9, 'Installation was successful; however, some file cleanup is not complete. To continue, you must restart your computer.')

    # (0x000d2f09) EOS hit during rewinding.
    NS_S_EOSRECEDING = HResultCode.new('NS_S_EOSRECEDING', 0x000d2f09, 'EOS hit during rewinding.')

    # (0x000d2f0d) Internal.
    NS_S_CHANGENOTICE = HResultCode.new('NS_S_CHANGENOTICE', 0x000d2f0d, 'Internal.')

    # (0x001f0001) The IO was completed by a filter.
    ERROR_FLT_IO_COMPLETE = HResultCode.new('ERROR_FLT_IO_COMPLETE', 0x001f0001, 'The IO was completed by a filter.')

    # (0x00262307) No mode is pinned on the specified VidPN source or target.
    ERROR_GRAPHICS_MODE_NOT_PINNED = HResultCode.new('ERROR_GRAPHICS_MODE_NOT_PINNED', 0x00262307, 'No mode is pinned on the specified VidPN source or target.')

    # (0x0026231e) Specified mode set does not specify preference for one of its modes.
    ERROR_GRAPHICS_NO_PREFERRED_MODE = HResultCode.new('ERROR_GRAPHICS_NO_PREFERRED_MODE', 0x0026231e, 'Specified mode set does not specify preference for one of its modes.')

    # (0x0026234b) Specified data set (for example, mode set, frequency range set, descriptor set, and topology) is empty.
    ERROR_GRAPHICS_DATASET_IS_EMPTY = HResultCode.new('ERROR_GRAPHICS_DATASET_IS_EMPTY', 0x0026234b, 'Specified data set (for example, mode set, frequency range set, descriptor set, and topology) is empty.')

    # (0x0026234c) Specified data set (for example, mode set, frequency range set, descriptor set, and topology) does not contain any more elements.
    ERROR_GRAPHICS_NO_MORE_ELEMENTS_IN_DATASET = HResultCode.new('ERROR_GRAPHICS_NO_MORE_ELEMENTS_IN_DATASET', 0x0026234c, 'Specified data set (for example, mode set, frequency range set, descriptor set, and topology) does not contain any more elements.')

    # (0x00262351) Specified content transformation is not pinned on the specified VidPN present path.
    ERROR_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_PINNED = HResultCode.new('ERROR_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_PINNED', 0x00262351, 'Specified content transformation is not pinned on the specified VidPN present path.')

    # (0x00300100) Property value will be ignored.
    PLA_S_PROPERTY_IGNORED = HResultCode.new('PLA_S_PROPERTY_IGNORED', 0x00300100, 'Property value will be ignored.')

    # (0x00340001) The request will be completed later by a Network Driver Interface Specification (NDIS) status indication.
    ERROR_NDIS_INDICATION_REQUIRED = HResultCode.new('ERROR_NDIS_INDICATION_REQUIRED', 0x00340001, 'The request will be completed later by a Network Driver Interface Specification (NDIS) status indication.')

    # (0x0dead100) The VolumeSequenceNumber of a MOVE_NOTIFICATION request is incorrect.
    TRK_S_OUT_OF_SYNC = HResultCode.new('TRK_S_OUT_OF_SYNC', 0x0dead100, 'The VolumeSequenceNumber of a MOVE_NOTIFICATION request is incorrect.')

    # (0x0dead102) The VolumeID in a request was not found in the server's ServerVolumeTable.
    TRK_VOLUME_NOT_FOUND = HResultCode.new('TRK_VOLUME_NOT_FOUND', 0x0dead102, 'The VolumeID in a request was not found in the server\'s ServerVolumeTable.')

    # (0x0dead103) A notification was sent to the LnkSvrMessage method, but the RequestMachine for the request was not the VolumeOwner for a VolumeID in the request.
    TRK_VOLUME_NOT_OWNED = HResultCode.new('TRK_VOLUME_NOT_OWNED', 0x0dead103, 'A notification was sent to the LnkSvrMessage method, but the RequestMachine for the request was not the VolumeOwner for a VolumeID in the request.')

    # (0x0dead107) The server received a MOVE_NOTIFICATION request, but the FileTable size limit has already been reached.
    TRK_S_NOTIFICATION_QUOTA_EXCEEDED = HResultCode.new('TRK_S_NOTIFICATION_QUOTA_EXCEEDED', 0x0dead107, 'The server received a MOVE_NOTIFICATION request, but the FileTable size limit has already been reached.')

    # (0x400d004f) The Title Server %1 is running.
    NS_I_TIGER_START = HResultCode.new('NS_I_TIGER_START', 0x400d004f, 'The Title Server %1 is running.')

    # (0x400d0051) Content Server %1 (%2) is starting.
    NS_I_CUB_START = HResultCode.new('NS_I_CUB_START', 0x400d0051, 'Content Server %1 (%2) is starting.')

    # (0x400d0052) Content Server %1 (%2) is running.
    NS_I_CUB_RUNNING = HResultCode.new('NS_I_CUB_RUNNING', 0x400d0052, 'Content Server %1 (%2) is running.')

    # (0x400d0054) Disk %1 ( %2 ) on Content Server %3, is running.
    NS_I_DISK_START = HResultCode.new('NS_I_DISK_START', 0x400d0054, 'Disk %1 ( %2 ) on Content Server %3, is running.')

    # (0x400d0056) Started rebuilding disk %1 ( %2 ) on Content Server %3.
    NS_I_DISK_REBUILD_STARTED = HResultCode.new('NS_I_DISK_REBUILD_STARTED', 0x400d0056, 'Started rebuilding disk %1 ( %2 ) on Content Server %3.')

    # (0x400d0057) Finished rebuilding disk %1 ( %2 ) on Content Server %3.
    NS_I_DISK_REBUILD_FINISHED = HResultCode.new('NS_I_DISK_REBUILD_FINISHED', 0x400d0057, 'Finished rebuilding disk %1 ( %2 ) on Content Server %3.')

    # (0x400d0058) Aborted rebuilding disk %1 ( %2 ) on Content Server %3.
    NS_I_DISK_REBUILD_ABORTED = HResultCode.new('NS_I_DISK_REBUILD_ABORTED', 0x400d0058, 'Aborted rebuilding disk %1 ( %2 ) on Content Server %3.')

    # (0x400d0059) A NetShow administrator at network location %1 set the data stream limit to %2 streams.
    NS_I_LIMIT_FUNNELS = HResultCode.new('NS_I_LIMIT_FUNNELS', 0x400d0059, 'A NetShow administrator at network location %1 set the data stream limit to %2 streams.')

    # (0x400d005a) A NetShow administrator at network location %1 started disk %2.
    NS_I_START_DISK = HResultCode.new('NS_I_START_DISK', 0x400d005a, 'A NetShow administrator at network location %1 started disk %2.')

    # (0x400d005b) A NetShow administrator at network location %1 stopped disk %2.
    NS_I_STOP_DISK = HResultCode.new('NS_I_STOP_DISK', 0x400d005b, 'A NetShow administrator at network location %1 stopped disk %2.')

    # (0x400d005c) A NetShow administrator at network location %1 stopped Content Server %2.
    NS_I_STOP_CUB = HResultCode.new('NS_I_STOP_CUB', 0x400d005c, 'A NetShow administrator at network location %1 stopped Content Server %2.')

    # (0x400d005d) A NetShow administrator at network location %1 aborted user session %2 from the system.
    NS_I_KILL_USERSESSION = HResultCode.new('NS_I_KILL_USERSESSION', 0x400d005d, 'A NetShow administrator at network location %1 aborted user session %2 from the system.')

    # (0x400d005e) A NetShow administrator at network location %1 aborted obsolete connection %2 from the system.
    NS_I_KILL_CONNECTION = HResultCode.new('NS_I_KILL_CONNECTION', 0x400d005e, 'A NetShow administrator at network location %1 aborted obsolete connection %2 from the system.')

    # (0x400d005f) A NetShow administrator at network location %1 started rebuilding disk %2.
    NS_I_REBUILD_DISK = HResultCode.new('NS_I_REBUILD_DISK', 0x400d005f, 'A NetShow administrator at network location %1 started rebuilding disk %2.')

    # (0x400d0069) Event initialization failed, there will be no MCM events.
    MCMADM_I_NO_EVENTS = HResultCode.new('MCMADM_I_NO_EVENTS', 0x400d0069, 'Event initialization failed, there will be no MCM events.')

    # (0x400d006e) The logging operation failed.
    NS_I_LOGGING_FAILED = HResultCode.new('NS_I_LOGGING_FAILED', 0x400d006e, 'The logging operation failed.')

    # (0x400d0070) A NetShow administrator at network location %1 set the maximum bandwidth limit to %2 bps.
    NS_I_LIMIT_BANDWIDTH = HResultCode.new('NS_I_LIMIT_BANDWIDTH', 0x400d0070, 'A NetShow administrator at network location %1 set the maximum bandwidth limit to %2 bps.')

    # (0x400d0191) Content Server %1 (%2) has established its link to Content Server %3.
    NS_I_CUB_UNFAIL_LINK = HResultCode.new('NS_I_CUB_UNFAIL_LINK', 0x400d0191, 'Content Server %1 (%2) has established its link to Content Server %3.')

    # (0x400d0193) Restripe operation has started.
    NS_I_RESTRIPE_START = HResultCode.new('NS_I_RESTRIPE_START', 0x400d0193, 'Restripe operation has started.')

    # (0x400d0194) Restripe operation has completed.
    NS_I_RESTRIPE_DONE = HResultCode.new('NS_I_RESTRIPE_DONE', 0x400d0194, 'Restripe operation has completed.')

    # (0x400d0196) Content disk %1 (%2) on Content Server %3 has been restriped out.
    NS_I_RESTRIPE_DISK_OUT = HResultCode.new('NS_I_RESTRIPE_DISK_OUT', 0x400d0196, 'Content disk %1 (%2) on Content Server %3 has been restriped out.')

    # (0x400d0197) Content server %1 (%2) has been restriped out.
    NS_I_RESTRIPE_CUB_OUT = HResultCode.new('NS_I_RESTRIPE_CUB_OUT', 0x400d0197, 'Content server %1 (%2) has been restriped out.')

    # (0x400d0198) Disk %1 ( %2 ) on Content Server %3, has been offlined.
    NS_I_DISK_STOP = HResultCode.new('NS_I_DISK_STOP', 0x400d0198, 'Disk %1 ( %2 ) on Content Server %3, has been offlined.')

    # (0x400d14be) The playlist change occurred while receding.
    NS_I_PLAYLIST_CHANGE_RECEDING = HResultCode.new('NS_I_PLAYLIST_CHANGE_RECEDING', 0x400d14be, 'The playlist change occurred while receding.')

    # (0x400d2eff) The client is reconnected.
    NS_I_RECONNECTED = HResultCode.new('NS_I_RECONNECTED', 0x400d2eff, 'The client is reconnected.')

    # (0x400d2f01) Forcing a switch to a pending header on start.
    NS_I_NOLOG_STOP = HResultCode.new('NS_I_NOLOG_STOP', 0x400d2f01, 'Forcing a switch to a pending header on start.')

    # (0x400d2f03) There is already an existing packetizer plugin for the stream.
    NS_I_EXISTING_PACKETIZER = HResultCode.new('NS_I_EXISTING_PACKETIZER', 0x400d2f03, 'There is already an existing packetizer plugin for the stream.')

    # (0x400d2f04) The proxy setting is manual.
    NS_I_MANUAL_PROXY = HResultCode.new('NS_I_MANUAL_PROXY', 0x400d2f04, 'The proxy setting is manual.')

    # (0x40262009) The kernel driver detected a version mismatch between it and the user mode driver.
    ERROR_GRAPHICS_DRIVER_MISMATCH = HResultCode.new('ERROR_GRAPHICS_DRIVER_MISMATCH', 0x40262009, 'The kernel driver detected a version mismatch between it and the user mode driver.')

    # (0x4026242f) Child device presence was not reliably detected.
    ERROR_GRAPHICS_UNKNOWN_CHILD_STATUS = HResultCode.new('ERROR_GRAPHICS_UNKNOWN_CHILD_STATUS', 0x4026242f, 'Child device presence was not reliably detected.')

    # (0x40262437) Starting the lead-link adapter has been deferred temporarily.
    ERROR_GRAPHICS_LEADLINK_START_DEFERRED = HResultCode.new('ERROR_GRAPHICS_LEADLINK_START_DEFERRED', 0x40262437, 'Starting the lead-link adapter has been deferred temporarily.')

    # (0x40262439) The display adapter is being polled for children too frequently at the same polling level.
    ERROR_GRAPHICS_POLLING_TOO_FREQUENTLY = HResultCode.new('ERROR_GRAPHICS_POLLING_TOO_FREQUENTLY', 0x40262439, 'The display adapter is being polled for children too frequently at the same polling level.')

    # (0x4026243a) Starting the adapter has been deferred temporarily.
    ERROR_GRAPHICS_START_DEFERRED = HResultCode.new('ERROR_GRAPHICS_START_DEFERRED', 0x4026243a, 'Starting the adapter has been deferred temporarily.')

    # (0x8000000a) The data necessary to complete this operation is not yet available.
    E_PENDING = HResultCode.new('E_PENDING', 0x8000000a, 'The data necessary to complete this operation is not yet available.')

    # (0x80004001) Not implemented.
    E_NOTIMPL = HResultCode.new('E_NOTIMPL', 0x80004001, 'Not implemented.')

    # (0x80004002) No such interface supported.
    E_NOINTERFACE = HResultCode.new('E_NOINTERFACE', 0x80004002, 'No such interface supported.')

    # (0x80004003) Invalid pointer.
    E_POINTER = HResultCode.new('E_POINTER', 0x80004003, 'Invalid pointer.')

    # (0x80004004) Operation aborted.
    E_ABORT = HResultCode.new('E_ABORT', 0x80004004, 'Operation aborted.')

    # (0x80004005) Unspecified error.
    E_FAIL = HResultCode.new('E_FAIL', 0x80004005, 'Unspecified error.')

    # (0x80004006) Thread local storage failure.
    CO_E_INIT_TLS = HResultCode.new('CO_E_INIT_TLS', 0x80004006, 'Thread local storage failure.')

    # (0x80004007) Get shared memory allocator failure.
    CO_E_INIT_SHARED_ALLOCATOR = HResultCode.new('CO_E_INIT_SHARED_ALLOCATOR', 0x80004007, 'Get shared memory allocator failure.')

    # (0x80004008) Get memory allocator failure.
    CO_E_INIT_MEMORY_ALLOCATOR = HResultCode.new('CO_E_INIT_MEMORY_ALLOCATOR', 0x80004008, 'Get memory allocator failure.')

    # (0x80004009) Unable to initialize class cache.
    CO_E_INIT_CLASS_CACHE = HResultCode.new('CO_E_INIT_CLASS_CACHE', 0x80004009, 'Unable to initialize class cache.')

    # (0x8000400a) Unable to initialize remote procedure call (RPC) services.
    CO_E_INIT_RPC_CHANNEL = HResultCode.new('CO_E_INIT_RPC_CHANNEL', 0x8000400a, 'Unable to initialize remote procedure call (RPC) services.')

    # (0x8000400b) Cannot set thread local storage channel control.
    CO_E_INIT_TLS_SET_CHANNEL_CONTROL = HResultCode.new('CO_E_INIT_TLS_SET_CHANNEL_CONTROL', 0x8000400b, 'Cannot set thread local storage channel control.')

    # (0x8000400c) Could not allocate thread local storage channel control.
    CO_E_INIT_TLS_CHANNEL_CONTROL = HResultCode.new('CO_E_INIT_TLS_CHANNEL_CONTROL', 0x8000400c, 'Could not allocate thread local storage channel control.')

    # (0x8000400d) The user-supplied memory allocator is unacceptable.
    CO_E_INIT_UNACCEPTED_USER_ALLOCATOR = HResultCode.new('CO_E_INIT_UNACCEPTED_USER_ALLOCATOR', 0x8000400d, 'The user-supplied memory allocator is unacceptable.')

    # (0x8000400e) The OLE service mutex already exists.
    CO_E_INIT_SCM_MUTEX_EXISTS = HResultCode.new('CO_E_INIT_SCM_MUTEX_EXISTS', 0x8000400e, 'The OLE service mutex already exists.')

    # (0x8000400f) The OLE service file mapping already exists.
    CO_E_INIT_SCM_FILE_MAPPING_EXISTS = HResultCode.new('CO_E_INIT_SCM_FILE_MAPPING_EXISTS', 0x8000400f, 'The OLE service file mapping already exists.')

    # (0x80004010) Unable to map view of file for OLE service.
    CO_E_INIT_SCM_MAP_VIEW_OF_FILE = HResultCode.new('CO_E_INIT_SCM_MAP_VIEW_OF_FILE', 0x80004010, 'Unable to map view of file for OLE service.')

    # (0x80004011) Failure attempting to launch OLE service.
    CO_E_INIT_SCM_EXEC_FAILURE = HResultCode.new('CO_E_INIT_SCM_EXEC_FAILURE', 0x80004011, 'Failure attempting to launch OLE service.')

    # (0x80004012) There was an attempt to call CoInitialize a second time while single-threaded.
    CO_E_INIT_ONLY_SINGLE_THREADED = HResultCode.new('CO_E_INIT_ONLY_SINGLE_THREADED', 0x80004012, 'There was an attempt to call CoInitialize a second time while single-threaded.')

    # (0x80004013) A Remote activation was necessary but was not allowed.
    CO_E_CANT_REMOTE = HResultCode.new('CO_E_CANT_REMOTE', 0x80004013, 'A Remote activation was necessary but was not allowed.')

    # (0x80004014) A Remote activation was necessary, but the server name provided was invalid.
    CO_E_BAD_SERVER_NAME = HResultCode.new('CO_E_BAD_SERVER_NAME', 0x80004014, 'A Remote activation was necessary, but the server name provided was invalid.')

    # (0x80004015) The class is configured to run as a security ID different from the caller.
    CO_E_WRONG_SERVER_IDENTITY = HResultCode.new('CO_E_WRONG_SERVER_IDENTITY', 0x80004015, 'The class is configured to run as a security ID different from the caller.')

    # (0x80004016) Use of OLE1 services requiring Dynamic Data Exchange (DDE) Windows is disabled.
    CO_E_OLE1DDE_DISABLED = HResultCode.new('CO_E_OLE1DDE_DISABLED', 0x80004016, 'Use of OLE1 services requiring Dynamic Data Exchange (DDE) Windows is disabled.')

    # (0x80004017) A RunAs specification must be <domain name>\<user name> or simply <user name>.
    CO_E_RUNAS_SYNTAX = HResultCode.new('CO_E_RUNAS_SYNTAX', 0x80004017, 'A RunAs specification must be <domain name>\<user name> or simply <user name>.')

    # (0x80004018) The server process could not be started. The path name might be incorrect.
    CO_E_CREATEPROCESS_FAILURE = HResultCode.new('CO_E_CREATEPROCESS_FAILURE', 0x80004018, 'The server process could not be started. The path name might be incorrect.')

    # (0x80004019) The server process could not be started as the configured identity. The path name might be incorrect or unavailable.
    CO_E_RUNAS_CREATEPROCESS_FAILURE = HResultCode.new('CO_E_RUNAS_CREATEPROCESS_FAILURE', 0x80004019, 'The server process could not be started as the configured identity. The path name might be incorrect or unavailable.')

    # (0x8000401a) The server process could not be started because the configured identity is incorrect. Check the user name and password.
    CO_E_RUNAS_LOGON_FAILURE = HResultCode.new('CO_E_RUNAS_LOGON_FAILURE', 0x8000401a, 'The server process could not be started because the configured identity is incorrect. Check the user name and password.')

    # (0x8000401b) The client is not allowed to launch this server.
    CO_E_LAUNCH_PERMSSION_DENIED = HResultCode.new('CO_E_LAUNCH_PERMSSION_DENIED', 0x8000401b, 'The client is not allowed to launch this server.')

    # (0x8000401c) The service providing this server could not be started.
    CO_E_START_SERVICE_FAILURE = HResultCode.new('CO_E_START_SERVICE_FAILURE', 0x8000401c, 'The service providing this server could not be started.')

    # (0x8000401d) This computer was unable to communicate with the computer providing the server.
    CO_E_REMOTE_COMMUNICATION_FAILURE = HResultCode.new('CO_E_REMOTE_COMMUNICATION_FAILURE', 0x8000401d, 'This computer was unable to communicate with the computer providing the server.')

    # (0x8000401e) The server did not respond after being launched.
    CO_E_SERVER_START_TIMEOUT = HResultCode.new('CO_E_SERVER_START_TIMEOUT', 0x8000401e, 'The server did not respond after being launched.')

    # (0x8000401f) The registration information for this server is inconsistent or incomplete.
    CO_E_CLSREG_INCONSISTENT = HResultCode.new('CO_E_CLSREG_INCONSISTENT', 0x8000401f, 'The registration information for this server is inconsistent or incomplete.')

    # (0x80004020) The registration information for this interface is inconsistent or incomplete.
    CO_E_IIDREG_INCONSISTENT = HResultCode.new('CO_E_IIDREG_INCONSISTENT', 0x80004020, 'The registration information for this interface is inconsistent or incomplete.')

    # (0x80004021) The operation attempted is not supported.
    CO_E_NOT_SUPPORTED = HResultCode.new('CO_E_NOT_SUPPORTED', 0x80004021, 'The operation attempted is not supported.')

    # (0x80004022) A DLL must be loaded.
    CO_E_RELOAD_DLL = HResultCode.new('CO_E_RELOAD_DLL', 0x80004022, 'A DLL must be loaded.')

    # (0x80004023) A Microsoft Software Installer error was encountered.
    CO_E_MSI_ERROR = HResultCode.new('CO_E_MSI_ERROR', 0x80004023, 'A Microsoft Software Installer error was encountered.')

    # (0x80004024) The specified activation could not occur in the client context as specified.
    CO_E_ATTEMPT_TO_CREATE_OUTSIDE_CLIENT_CONTEXT = HResultCode.new('CO_E_ATTEMPT_TO_CREATE_OUTSIDE_CLIENT_CONTEXT', 0x80004024, 'The specified activation could not occur in the client context as specified.')

    # (0x80004025) Activations on the server are paused.
    CO_E_SERVER_PAUSED = HResultCode.new('CO_E_SERVER_PAUSED', 0x80004025, 'Activations on the server are paused.')

    # (0x80004026) Activations on the server are not paused.
    CO_E_SERVER_NOT_PAUSED = HResultCode.new('CO_E_SERVER_NOT_PAUSED', 0x80004026, 'Activations on the server are not paused.')

    # (0x80004027) The component or application containing the component has been disabled.
    CO_E_CLASS_DISABLED = HResultCode.new('CO_E_CLASS_DISABLED', 0x80004027, 'The component or application containing the component has been disabled.')

    # (0x80004028) The common language runtime is not available.
    CO_E_CLRNOTAVAILABLE = HResultCode.new('CO_E_CLRNOTAVAILABLE', 0x80004028, 'The common language runtime is not available.')

    # (0x80004029) The thread-pool rejected the submitted asynchronous work.
    CO_E_ASYNC_WORK_REJECTED = HResultCode.new('CO_E_ASYNC_WORK_REJECTED', 0x80004029, 'The thread-pool rejected the submitted asynchronous work.')

    # (0x8000402a) The server started, but it did not finish initializing in a timely fashion.
    CO_E_SERVER_INIT_TIMEOUT = HResultCode.new('CO_E_SERVER_INIT_TIMEOUT', 0x8000402a, 'The server started, but it did not finish initializing in a timely fashion.')

    # (0x8000402b) Unable to complete the call because there is no COM+ security context inside IObjectControl.Activate.
    CO_E_NO_SECCTX_IN_ACTIVATE = HResultCode.new('CO_E_NO_SECCTX_IN_ACTIVATE', 0x8000402b, 'Unable to complete the call because there is no COM+ security context inside IObjectControl.Activate.')

    # (0x80004030) The provided tracker configuration is invalid.
    CO_E_TRACKER_CONFIG = HResultCode.new('CO_E_TRACKER_CONFIG', 0x80004030, 'The provided tracker configuration is invalid.')

    # (0x80004031) The provided thread pool configuration is invalid.
    CO_E_THREADPOOL_CONFIG = HResultCode.new('CO_E_THREADPOOL_CONFIG', 0x80004031, 'The provided thread pool configuration is invalid.')

    # (0x80004032) The provided side-by-side configuration is invalid.
    CO_E_SXS_CONFIG = HResultCode.new('CO_E_SXS_CONFIG', 0x80004032, 'The provided side-by-side configuration is invalid.')

    # (0x80004033) The server principal name (SPN) obtained during security negotiation is malformed.
    CO_E_MALFORMED_SPN = HResultCode.new('CO_E_MALFORMED_SPN', 0x80004033, 'The server principal name (SPN) obtained during security negotiation is malformed.')

    # (0x8000ffff) Catastrophic failure.
    E_UNEXPECTED = HResultCode.new('E_UNEXPECTED', 0x8000ffff, 'Catastrophic failure.')

    # (0x80010001) Call was rejected by callee.
    RPC_E_CALL_REJECTED = HResultCode.new('RPC_E_CALL_REJECTED', 0x80010001, 'Call was rejected by callee.')

    # (0x80010002) Call was canceled by the message filter.
    RPC_E_CALL_CANCELED = HResultCode.new('RPC_E_CALL_CANCELED', 0x80010002, 'Call was canceled by the message filter.')

    # (0x80010003) The caller is dispatching an intertask SendMessage call and cannot call out via PostMessage.
    RPC_E_CANTPOST_INSENDCALL = HResultCode.new('RPC_E_CANTPOST_INSENDCALL', 0x80010003, 'The caller is dispatching an intertask SendMessage call and cannot call out via PostMessage.')

    # (0x80010004) The caller is dispatching an asynchronous call and cannot make an outgoing call on behalf of this call.
    RPC_E_CANTCALLOUT_INASYNCCALL = HResultCode.new('RPC_E_CANTCALLOUT_INASYNCCALL', 0x80010004, 'The caller is dispatching an asynchronous call and cannot make an outgoing call on behalf of this call.')

    # (0x80010005) It is illegal to call out while inside message filter.
    RPC_E_CANTCALLOUT_INEXTERNALCALL = HResultCode.new('RPC_E_CANTCALLOUT_INEXTERNALCALL', 0x80010005, 'It is illegal to call out while inside message filter.')

    # (0x80010006) The connection terminated or is in a bogus state and can no longer be used. Other connections are still valid.
    RPC_E_CONNECTION_TERMINATED = HResultCode.new('RPC_E_CONNECTION_TERMINATED', 0x80010006, 'The connection terminated or is in a bogus state and can no longer be used. Other connections are still valid.')

    # (0x80010007) The callee (the server, not the server application) is not available and disappeared; all connections are invalid. The call might have executed.
    RPC_E_SERVER_DIED = HResultCode.new('RPC_E_SERVER_DIED', 0x80010007, 'The callee (the server, not the server application) is not available and disappeared; all connections are invalid. The call might have executed.')

    # (0x80010008) The caller (client) disappeared while the callee (server) was processing a call.
    RPC_E_CLIENT_DIED = HResultCode.new('RPC_E_CLIENT_DIED', 0x80010008, 'The caller (client) disappeared while the callee (server) was processing a call.')

    # (0x80010009) The data packet with the marshaled parameter data is incorrect.
    RPC_E_INVALID_DATAPACKET = HResultCode.new('RPC_E_INVALID_DATAPACKET', 0x80010009, 'The data packet with the marshaled parameter data is incorrect.')

    # (0x8001000a) The call was not transmitted properly; the message queue was full and was not emptied after yielding.
    RPC_E_CANTTRANSMIT_CALL = HResultCode.new('RPC_E_CANTTRANSMIT_CALL', 0x8001000a, 'The call was not transmitted properly; the message queue was full and was not emptied after yielding.')

    # (0x8001000b) The client RPC caller cannot marshal the parameter data due to errors (such as low memory).
    RPC_E_CLIENT_CANTMARSHAL_DATA = HResultCode.new('RPC_E_CLIENT_CANTMARSHAL_DATA', 0x8001000b, 'The client RPC caller cannot marshal the parameter data due to errors (such as low memory).')

    # (0x8001000c) The client RPC caller cannot unmarshal the return data due to errors (such as low memory).
    RPC_E_CLIENT_CANTUNMARSHAL_DATA = HResultCode.new('RPC_E_CLIENT_CANTUNMARSHAL_DATA', 0x8001000c, 'The client RPC caller cannot unmarshal the return data due to errors (such as low memory).')

    # (0x8001000d) The server RPC callee cannot marshal the return data due to errors (such as low memory).
    RPC_E_SERVER_CANTMARSHAL_DATA = HResultCode.new('RPC_E_SERVER_CANTMARSHAL_DATA', 0x8001000d, 'The server RPC callee cannot marshal the return data due to errors (such as low memory).')

    # (0x8001000e) The server RPC callee cannot unmarshal the parameter data due to errors (such as low memory).
    RPC_E_SERVER_CANTUNMARSHAL_DATA = HResultCode.new('RPC_E_SERVER_CANTUNMARSHAL_DATA', 0x8001000e, 'The server RPC callee cannot unmarshal the parameter data due to errors (such as low memory).')

    # (0x8001000f) Received data is invalid. The data might be server or client data.
    RPC_E_INVALID_DATA = HResultCode.new('RPC_E_INVALID_DATA', 0x8001000f, 'Received data is invalid. The data might be server or client data.')

    # (0x80010010) A particular parameter is invalid and cannot be (un)marshaled.
    RPC_E_INVALID_PARAMETER = HResultCode.new('RPC_E_INVALID_PARAMETER', 0x80010010, 'A particular parameter is invalid and cannot be (un)marshaled.')

    # (0x80010011) There is no second outgoing call on same channel in DDE conversation.
    RPC_E_CANTCALLOUT_AGAIN = HResultCode.new('RPC_E_CANTCALLOUT_AGAIN', 0x80010011, 'There is no second outgoing call on same channel in DDE conversation.')

    # (0x80010012) The callee (the server, not the server application) is not available and disappeared; all connections are invalid. The call did not execute.
    RPC_E_SERVER_DIED_DNE = HResultCode.new('RPC_E_SERVER_DIED_DNE', 0x80010012, 'The callee (the server, not the server application) is not available and disappeared; all connections are invalid. The call did not execute.')

    # (0x80010100) System call failed.
    RPC_E_SYS_CALL_FAILED = HResultCode.new('RPC_E_SYS_CALL_FAILED', 0x80010100, 'System call failed.')

    # (0x80010101) Could not allocate some required resource (such as memory or events)
    RPC_E_OUT_OF_RESOURCES = HResultCode.new('RPC_E_OUT_OF_RESOURCES', 0x80010101, 'Could not allocate some required resource (such as memory or events)')

    # (0x80010102) Attempted to make calls on more than one thread in single-threaded mode.
    RPC_E_ATTEMPTED_MULTITHREAD = HResultCode.new('RPC_E_ATTEMPTED_MULTITHREAD', 0x80010102, 'Attempted to make calls on more than one thread in single-threaded mode.')

    # (0x80010103) The requested interface is not registered on the server object.
    RPC_E_NOT_REGISTERED = HResultCode.new('RPC_E_NOT_REGISTERED', 0x80010103, 'The requested interface is not registered on the server object.')

    # (0x80010104) RPC could not call the server or could not return the results of calling the server.
    RPC_E_FAULT = HResultCode.new('RPC_E_FAULT', 0x80010104, 'RPC could not call the server or could not return the results of calling the server.')

    # (0x80010105) The server threw an exception.
    RPC_E_SERVERFAULT = HResultCode.new('RPC_E_SERVERFAULT', 0x80010105, 'The server threw an exception.')

    # (0x80010106) Cannot change thread mode after it is set.
    RPC_E_CHANGED_MODE = HResultCode.new('RPC_E_CHANGED_MODE', 0x80010106, 'Cannot change thread mode after it is set.')

    # (0x80010107) The method called does not exist on the server.
    RPC_E_INVALIDMETHOD = HResultCode.new('RPC_E_INVALIDMETHOD', 0x80010107, 'The method called does not exist on the server.')

    # (0x80010108) The object invoked has disconnected from its clients.
    RPC_E_DISCONNECTED = HResultCode.new('RPC_E_DISCONNECTED', 0x80010108, 'The object invoked has disconnected from its clients.')

    # (0x80010109) The object invoked chose not to process the call now. Try again later.
    RPC_E_RETRY = HResultCode.new('RPC_E_RETRY', 0x80010109, 'The object invoked chose not to process the call now. Try again later.')

    # (0x8001010a) The message filter indicated that the application is busy.
    RPC_E_SERVERCALL_RETRYLATER = HResultCode.new('RPC_E_SERVERCALL_RETRYLATER', 0x8001010a, 'The message filter indicated that the application is busy.')

    # (0x8001010b) The message filter rejected the call.
    RPC_E_SERVERCALL_REJECTED = HResultCode.new('RPC_E_SERVERCALL_REJECTED', 0x8001010b, 'The message filter rejected the call.')

    # (0x8001010c) A call control interface was called with invalid data.
    RPC_E_INVALID_CALLDATA = HResultCode.new('RPC_E_INVALID_CALLDATA', 0x8001010c, 'A call control interface was called with invalid data.')

    # (0x8001010d) An outgoing call cannot be made because the application is dispatching an input-synchronous call.
    RPC_E_CANTCALLOUT_ININPUTSYNCCALL = HResultCode.new('RPC_E_CANTCALLOUT_ININPUTSYNCCALL', 0x8001010d, 'An outgoing call cannot be made because the application is dispatching an input-synchronous call.')

    # (0x8001010e) The application called an interface that was marshaled for a different thread.
    RPC_E_WRONG_THREAD = HResultCode.new('RPC_E_WRONG_THREAD', 0x8001010e, 'The application called an interface that was marshaled for a different thread.')

    # (0x8001010f) CoInitialize has not been called on the current thread.
    RPC_E_THREAD_NOT_INIT = HResultCode.new('RPC_E_THREAD_NOT_INIT', 0x8001010f, 'CoInitialize has not been called on the current thread.')

    # (0x80010110) The version of OLE on the client and server machines does not match.
    RPC_E_VERSION_MISMATCH = HResultCode.new('RPC_E_VERSION_MISMATCH', 0x80010110, 'The version of OLE on the client and server machines does not match.')

    # (0x80010111) OLE received a packet with an invalid header.
    RPC_E_INVALID_HEADER = HResultCode.new('RPC_E_INVALID_HEADER', 0x80010111, 'OLE received a packet with an invalid header.')

    # (0x80010112) OLE received a packet with an invalid extension.
    RPC_E_INVALID_EXTENSION = HResultCode.new('RPC_E_INVALID_EXTENSION', 0x80010112, 'OLE received a packet with an invalid extension.')

    # (0x80010113) The requested object or interface does not exist.
    RPC_E_INVALID_IPID = HResultCode.new('RPC_E_INVALID_IPID', 0x80010113, 'The requested object or interface does not exist.')

    # (0x80010114) The requested object does not exist.
    RPC_E_INVALID_OBJECT = HResultCode.new('RPC_E_INVALID_OBJECT', 0x80010114, 'The requested object does not exist.')

    # (0x80010115) OLE has sent a request and is waiting for a reply.
    RPC_S_CALLPENDING = HResultCode.new('RPC_S_CALLPENDING', 0x80010115, 'OLE has sent a request and is waiting for a reply.')

    # (0x80010116) OLE is waiting before retrying a request.
    RPC_S_WAITONTIMER = HResultCode.new('RPC_S_WAITONTIMER', 0x80010116, 'OLE is waiting before retrying a request.')

    # (0x80010117) Call context cannot be accessed after call completed.
    RPC_E_CALL_COMPLETE = HResultCode.new('RPC_E_CALL_COMPLETE', 0x80010117, 'Call context cannot be accessed after call completed.')

    # (0x80010118) Impersonate on unsecure calls is not supported.
    RPC_E_UNSECURE_CALL = HResultCode.new('RPC_E_UNSECURE_CALL', 0x80010118, 'Impersonate on unsecure calls is not supported.')

    # (0x80010119) Security must be initialized before any interfaces are marshaled or unmarshaled. It cannot be changed after initialized.
    RPC_E_TOO_LATE = HResultCode.new('RPC_E_TOO_LATE', 0x80010119, 'Security must be initialized before any interfaces are marshaled or unmarshaled. It cannot be changed after initialized.')

    # (0x8001011a) No security packages are installed on this machine, the user is not logged on, or there are no compatible security packages between the client and server.
    RPC_E_NO_GOOD_SECURITY_PACKAGES = HResultCode.new('RPC_E_NO_GOOD_SECURITY_PACKAGES', 0x8001011a, 'No security packages are installed on this machine, the user is not logged on, or there are no compatible security packages between the client and server.')

    # (0x8001011b) Access is denied.
    RPC_E_ACCESS_DENIED = HResultCode.new('RPC_E_ACCESS_DENIED', 0x8001011b, 'Access is denied.')

    # (0x8001011c) Remote calls are not allowed for this process.
    RPC_E_REMOTE_DISABLED = HResultCode.new('RPC_E_REMOTE_DISABLED', 0x8001011c, 'Remote calls are not allowed for this process.')

    # (0x8001011d) The marshaled interface data packet (OBJREF) has an invalid or unknown format.
    RPC_E_INVALID_OBJREF = HResultCode.new('RPC_E_INVALID_OBJREF', 0x8001011d, 'The marshaled interface data packet (OBJREF) has an invalid or unknown format.')

    # (0x8001011e) No context is associated with this call. This happens for some custom marshaled calls and on the client side of the call.
    RPC_E_NO_CONTEXT = HResultCode.new('RPC_E_NO_CONTEXT', 0x8001011e, 'No context is associated with this call. This happens for some custom marshaled calls and on the client side of the call.')

    # (0x8001011f) This operation returned because the time-out period expired.
    RPC_E_TIMEOUT = HResultCode.new('RPC_E_TIMEOUT', 0x8001011f, 'This operation returned because the time-out period expired.')

    # (0x80010120) There are no synchronize objects to wait on.
    RPC_E_NO_SYNC = HResultCode.new('RPC_E_NO_SYNC', 0x80010120, 'There are no synchronize objects to wait on.')

    # (0x80010121) Full subject issuer chain Secure Sockets Layer (SSL) principal name expected from the server.
    RPC_E_FULLSIC_REQUIRED = HResultCode.new('RPC_E_FULLSIC_REQUIRED', 0x80010121, 'Full subject issuer chain Secure Sockets Layer (SSL) principal name expected from the server.')

    # (0x80010122) Principal name is not a valid Microsoft standard (msstd) name.
    RPC_E_INVALID_STD_NAME = HResultCode.new('RPC_E_INVALID_STD_NAME', 0x80010122, 'Principal name is not a valid Microsoft standard (msstd) name.')

    # (0x80010123) Unable to impersonate DCOM client.
    CO_E_FAILEDTOIMPERSONATE = HResultCode.new('CO_E_FAILEDTOIMPERSONATE', 0x80010123, 'Unable to impersonate DCOM client.')

    # (0x80010124) Unable to obtain server's security context.
    CO_E_FAILEDTOGETSECCTX = HResultCode.new('CO_E_FAILEDTOGETSECCTX', 0x80010124, 'Unable to obtain server\'s security context.')

    # (0x80010125) Unable to open the access token of the current thread.
    CO_E_FAILEDTOOPENTHREADTOKEN = HResultCode.new('CO_E_FAILEDTOOPENTHREADTOKEN', 0x80010125, 'Unable to open the access token of the current thread.')

    # (0x80010126) Unable to obtain user information from an access token.
    CO_E_FAILEDTOGETTOKENINFO = HResultCode.new('CO_E_FAILEDTOGETTOKENINFO', 0x80010126, 'Unable to obtain user information from an access token.')

    # (0x80010127) The client who called IAccessControl::IsAccessPermitted was not the trustee provided to the method.
    CO_E_TRUSTEEDOESNTMATCHCLIENT = HResultCode.new('CO_E_TRUSTEEDOESNTMATCHCLIENT', 0x80010127, 'The client who called IAccessControl::IsAccessPermitted was not the trustee provided to the method.')

    # (0x80010128) Unable to obtain the client's security blanket.
    CO_E_FAILEDTOQUERYCLIENTBLANKET = HResultCode.new('CO_E_FAILEDTOQUERYCLIENTBLANKET', 0x80010128, 'Unable to obtain the client\'s security blanket.')

    # (0x80010129) Unable to set a discretionary access control list (ACL) into a security descriptor.
    CO_E_FAILEDTOSETDACL = HResultCode.new('CO_E_FAILEDTOSETDACL', 0x80010129, 'Unable to set a discretionary access control list (ACL) into a security descriptor.')

    # (0x8001012a) The system function AccessCheck returned false.
    CO_E_ACCESSCHECKFAILED = HResultCode.new('CO_E_ACCESSCHECKFAILED', 0x8001012a, 'The system function AccessCheck returned false.')

    # (0x8001012b) Either NetAccessDel or NetAccessAdd returned an error code.
    CO_E_NETACCESSAPIFAILED = HResultCode.new('CO_E_NETACCESSAPIFAILED', 0x8001012b, 'Either NetAccessDel or NetAccessAdd returned an error code.')

    # (0x8001012c) One of the trustee strings provided by the user did not conform to the <Domain>\<Name> syntax and it was not the *" string".
    CO_E_WRONGTRUSTEENAMESYNTAX = HResultCode.new('CO_E_WRONGTRUSTEENAMESYNTAX', 0x8001012c, 'One of the trustee strings provided by the user did not conform to the <Domain>\<Name> syntax and it was not the *" string".')

    # (0x8001012d) One of the security identifiers provided by the user was invalid.
    CO_E_INVALIDSID = HResultCode.new('CO_E_INVALIDSID', 0x8001012d, 'One of the security identifiers provided by the user was invalid.')

    # (0x8001012e) Unable to convert a wide character trustee string to a multiple-byte trustee string.
    CO_E_CONVERSIONFAILED = HResultCode.new('CO_E_CONVERSIONFAILED', 0x8001012e, 'Unable to convert a wide character trustee string to a multiple-byte trustee string.')

    # (0x8001012f) Unable to find a security identifier that corresponds to a trustee string provided by the user.
    CO_E_NOMATCHINGSIDFOUND = HResultCode.new('CO_E_NOMATCHINGSIDFOUND', 0x8001012f, 'Unable to find a security identifier that corresponds to a trustee string provided by the user.')

    # (0x80010130) The system function LookupAccountSID failed.
    CO_E_LOOKUPACCSIDFAILED = HResultCode.new('CO_E_LOOKUPACCSIDFAILED', 0x80010130, 'The system function LookupAccountSID failed.')

    # (0x80010131) Unable to find a trustee name that corresponds to a security identifier provided by the user.
    CO_E_NOMATCHINGNAMEFOUND = HResultCode.new('CO_E_NOMATCHINGNAMEFOUND', 0x80010131, 'Unable to find a trustee name that corresponds to a security identifier provided by the user.')

    # (0x80010132) The system function LookupAccountName failed.
    CO_E_LOOKUPACCNAMEFAILED = HResultCode.new('CO_E_LOOKUPACCNAMEFAILED', 0x80010132, 'The system function LookupAccountName failed.')

    # (0x80010133) Unable to set or reset a serialization handle.
    CO_E_SETSERLHNDLFAILED = HResultCode.new('CO_E_SETSERLHNDLFAILED', 0x80010133, 'Unable to set or reset a serialization handle.')

    # (0x80010134) Unable to obtain the Windows directory.
    CO_E_FAILEDTOGETWINDIR = HResultCode.new('CO_E_FAILEDTOGETWINDIR', 0x80010134, 'Unable to obtain the Windows directory.')

    # (0x80010135) Path too long.
    CO_E_PATHTOOLONG = HResultCode.new('CO_E_PATHTOOLONG', 0x80010135, 'Path too long.')

    # (0x80010136) Unable to generate a UUID.
    CO_E_FAILEDTOGENUUID = HResultCode.new('CO_E_FAILEDTOGENUUID', 0x80010136, 'Unable to generate a UUID.')

    # (0x80010137) Unable to create file.
    CO_E_FAILEDTOCREATEFILE = HResultCode.new('CO_E_FAILEDTOCREATEFILE', 0x80010137, 'Unable to create file.')

    # (0x80010138) Unable to close a serialization handle or a file handle.
    CO_E_FAILEDTOCLOSEHANDLE = HResultCode.new('CO_E_FAILEDTOCLOSEHANDLE', 0x80010138, 'Unable to close a serialization handle or a file handle.')

    # (0x80010139) The number of access control entries (ACEs) in an ACL exceeds the system limit.
    CO_E_EXCEEDSYSACLLIMIT = HResultCode.new('CO_E_EXCEEDSYSACLLIMIT', 0x80010139, 'The number of access control entries (ACEs) in an ACL exceeds the system limit.')

    # (0x8001013a) Not all the DENY_ACCESS ACEs are arranged in front of the GRANT_ACCESS ACEs in the stream.
    CO_E_ACESINWRONGORDER = HResultCode.new('CO_E_ACESINWRONGORDER', 0x8001013a, 'Not all the DENY_ACCESS ACEs are arranged in front of the GRANT_ACCESS ACEs in the stream.')

    # (0x8001013b) The version of ACL format in the stream is not supported by this implementation of IAccessControl.
    CO_E_INCOMPATIBLESTREAMVERSION = HResultCode.new('CO_E_INCOMPATIBLESTREAMVERSION', 0x8001013b, 'The version of ACL format in the stream is not supported by this implementation of IAccessControl.')

    # (0x8001013c) Unable to open the access token of the server process.
    CO_E_FAILEDTOOPENPROCESSTOKEN = HResultCode.new('CO_E_FAILEDTOOPENPROCESSTOKEN', 0x8001013c, 'Unable to open the access token of the server process.')

    # (0x8001013d) Unable to decode the ACL in the stream provided by the user.
    CO_E_DECODEFAILED = HResultCode.new('CO_E_DECODEFAILED', 0x8001013d, 'Unable to decode the ACL in the stream provided by the user.')

    # (0x8001013f) The COM IAccessControl object is not initialized.
    CO_E_ACNOTINITIALIZED = HResultCode.new('CO_E_ACNOTINITIALIZED', 0x8001013f, 'The COM IAccessControl object is not initialized.')

    # (0x80010140) Call Cancellation is disabled.
    CO_E_CANCEL_DISABLED = HResultCode.new('CO_E_CANCEL_DISABLED', 0x80010140, 'Call Cancellation is disabled.')

    # (0x8001ffff) An internal error occurred.
    RPC_E_UNEXPECTED = HResultCode.new('RPC_E_UNEXPECTED', 0x8001ffff, 'An internal error occurred.')

    # (0x80020001) Unknown interface.
    DISP_E_UNKNOWNINTERFACE = HResultCode.new('DISP_E_UNKNOWNINTERFACE', 0x80020001, 'Unknown interface.')

    # (0x80020003) Member not found.
    DISP_E_MEMBERNOTFOUND = HResultCode.new('DISP_E_MEMBERNOTFOUND', 0x80020003, 'Member not found.')

    # (0x80020004) Parameter not found.
    DISP_E_PARAMNOTFOUND = HResultCode.new('DISP_E_PARAMNOTFOUND', 0x80020004, 'Parameter not found.')

    # (0x80020005) Type mismatch.
    DISP_E_TYPEMISMATCH = HResultCode.new('DISP_E_TYPEMISMATCH', 0x80020005, 'Type mismatch.')

    # (0x80020006) Unknown name.
    DISP_E_UNKNOWNNAME = HResultCode.new('DISP_E_UNKNOWNNAME', 0x80020006, 'Unknown name.')

    # (0x80020007) No named arguments.
    DISP_E_NONAMEDARGS = HResultCode.new('DISP_E_NONAMEDARGS', 0x80020007, 'No named arguments.')

    # (0x80020008) Bad variable type.
    DISP_E_BADVARTYPE = HResultCode.new('DISP_E_BADVARTYPE', 0x80020008, 'Bad variable type.')

    # (0x80020009) Exception occurred.
    DISP_E_EXCEPTION = HResultCode.new('DISP_E_EXCEPTION', 0x80020009, 'Exception occurred.')

    # (0x8002000a) Out of present range.
    DISP_E_OVERFLOW = HResultCode.new('DISP_E_OVERFLOW', 0x8002000a, 'Out of present range.')

    # (0x8002000b) Invalid index.
    DISP_E_BADINDEX = HResultCode.new('DISP_E_BADINDEX', 0x8002000b, 'Invalid index.')

    # (0x8002000c) Unknown language.
    DISP_E_UNKNOWNLCID = HResultCode.new('DISP_E_UNKNOWNLCID', 0x8002000c, 'Unknown language.')

    # (0x8002000d) Memory is locked.
    DISP_E_ARRAYISLOCKED = HResultCode.new('DISP_E_ARRAYISLOCKED', 0x8002000d, 'Memory is locked.')

    # (0x8002000e) Invalid number of parameters.
    DISP_E_BADPARAMCOUNT = HResultCode.new('DISP_E_BADPARAMCOUNT', 0x8002000e, 'Invalid number of parameters.')

    # (0x8002000f) Parameter not optional.
    DISP_E_PARAMNOTOPTIONAL = HResultCode.new('DISP_E_PARAMNOTOPTIONAL', 0x8002000f, 'Parameter not optional.')

    # (0x80020010) Invalid callee.
    DISP_E_BADCALLEE = HResultCode.new('DISP_E_BADCALLEE', 0x80020010, 'Invalid callee.')

    # (0x80020011) Does not support a collection.
    DISP_E_NOTACOLLECTION = HResultCode.new('DISP_E_NOTACOLLECTION', 0x80020011, 'Does not support a collection.')

    # (0x80020012) Division by zero.
    DISP_E_DIVBYZERO = HResultCode.new('DISP_E_DIVBYZERO', 0x80020012, 'Division by zero.')

    # (0x80020013) Buffer too small.
    DISP_E_BUFFERTOOSMALL = HResultCode.new('DISP_E_BUFFERTOOSMALL', 0x80020013, 'Buffer too small.')

    # (0x80028016) Buffer too small.
    TYPE_E_BUFFERTOOSMALL = HResultCode.new('TYPE_E_BUFFERTOOSMALL', 0x80028016, 'Buffer too small.')

    # (0x80028017) Field name not defined in the record.
    TYPE_E_FIELDNOTFOUND = HResultCode.new('TYPE_E_FIELDNOTFOUND', 0x80028017, 'Field name not defined in the record.')

    # (0x80028018) Old format or invalid type library.
    TYPE_E_INVDATAREAD = HResultCode.new('TYPE_E_INVDATAREAD', 0x80028018, 'Old format or invalid type library.')

    # (0x80028019) Old format or invalid type library.
    TYPE_E_UNSUPFORMAT = HResultCode.new('TYPE_E_UNSUPFORMAT', 0x80028019, 'Old format or invalid type library.')

    # (0x8002801c) Error accessing the OLE registry.
    TYPE_E_REGISTRYACCESS = HResultCode.new('TYPE_E_REGISTRYACCESS', 0x8002801c, 'Error accessing the OLE registry.')

    # (0x8002801d) Library not registered.
    TYPE_E_LIBNOTREGISTERED = HResultCode.new('TYPE_E_LIBNOTREGISTERED', 0x8002801d, 'Library not registered.')

    # (0x80028027) Bound to unknown type.
    TYPE_E_UNDEFINEDTYPE = HResultCode.new('TYPE_E_UNDEFINEDTYPE', 0x80028027, 'Bound to unknown type.')

    # (0x80028028) Qualified name disallowed.
    TYPE_E_QUALIFIEDNAMEDISALLOWED = HResultCode.new('TYPE_E_QUALIFIEDNAMEDISALLOWED', 0x80028028, 'Qualified name disallowed.')

    # (0x80028029) Invalid forward reference, or reference to uncompiled type.
    TYPE_E_INVALIDSTATE = HResultCode.new('TYPE_E_INVALIDSTATE', 0x80028029, 'Invalid forward reference, or reference to uncompiled type.')

    # (0x8002802a) Type mismatch.
    TYPE_E_WRONGTYPEKIND = HResultCode.new('TYPE_E_WRONGTYPEKIND', 0x8002802a, 'Type mismatch.')

    # (0x8002802b) Element not found.
    TYPE_E_ELEMENTNOTFOUND = HResultCode.new('TYPE_E_ELEMENTNOTFOUND', 0x8002802b, 'Element not found.')

    # (0x8002802c) Ambiguous name.
    TYPE_E_AMBIGUOUSNAME = HResultCode.new('TYPE_E_AMBIGUOUSNAME', 0x8002802c, 'Ambiguous name.')

    # (0x8002802d) Name already exists in the library.
    TYPE_E_NAMECONFLICT = HResultCode.new('TYPE_E_NAMECONFLICT', 0x8002802d, 'Name already exists in the library.')

    # (0x8002802e) Unknown language code identifier (LCID).
    TYPE_E_UNKNOWNLCID = HResultCode.new('TYPE_E_UNKNOWNLCID', 0x8002802e, 'Unknown language code identifier (LCID).')

    # (0x8002802f) Function not defined in specified DLL.
    TYPE_E_DLLFUNCTIONNOTFOUND = HResultCode.new('TYPE_E_DLLFUNCTIONNOTFOUND', 0x8002802f, 'Function not defined in specified DLL.')

    # (0x800288bd) Wrong module kind for the operation.
    TYPE_E_BADMODULEKIND = HResultCode.new('TYPE_E_BADMODULEKIND', 0x800288bd, 'Wrong module kind for the operation.')

    # (0x800288c5) Size cannot exceed 64 KB.
    TYPE_E_SIZETOOBIG = HResultCode.new('TYPE_E_SIZETOOBIG', 0x800288c5, 'Size cannot exceed 64 KB.')

    # (0x800288c6) Duplicate ID in inheritance hierarchy.
    TYPE_E_DUPLICATEID = HResultCode.new('TYPE_E_DUPLICATEID', 0x800288c6, 'Duplicate ID in inheritance hierarchy.')

    # (0x800288cf) Incorrect inheritance depth in standard OLE hmember.
    TYPE_E_INVALIDID = HResultCode.new('TYPE_E_INVALIDID', 0x800288cf, 'Incorrect inheritance depth in standard OLE hmember.')

    # (0x80028ca0) Type mismatch.
    TYPE_E_TYPEMISMATCH = HResultCode.new('TYPE_E_TYPEMISMATCH', 0x80028ca0, 'Type mismatch.')

    # (0x80028ca1) Invalid number of arguments.
    TYPE_E_OUTOFBOUNDS = HResultCode.new('TYPE_E_OUTOFBOUNDS', 0x80028ca1, 'Invalid number of arguments.')

    # (0x80028ca2) I/O error.
    TYPE_E_IOERROR = HResultCode.new('TYPE_E_IOERROR', 0x80028ca2, 'I/O error.')

    # (0x80028ca3) Error creating unique .tmp file.
    TYPE_E_CANTCREATETMPFILE = HResultCode.new('TYPE_E_CANTCREATETMPFILE', 0x80028ca3, 'Error creating unique .tmp file.')

    # (0x80029c4a) Error loading type library or DLL.
    TYPE_E_CANTLOADLIBRARY = HResultCode.new('TYPE_E_CANTLOADLIBRARY', 0x80029c4a, 'Error loading type library or DLL.')

    # (0x80029c83) Inconsistent property functions.
    TYPE_E_INCONSISTENTPROPFUNCS = HResultCode.new('TYPE_E_INCONSISTENTPROPFUNCS', 0x80029c83, 'Inconsistent property functions.')

    # (0x80029c84) Circular dependency between types and modules.
    TYPE_E_CIRCULARTYPE = HResultCode.new('TYPE_E_CIRCULARTYPE', 0x80029c84, 'Circular dependency between types and modules.')

    # (0x80030001) Unable to perform requested operation.
    STG_E_INVALIDFUNCTION = HResultCode.new('STG_E_INVALIDFUNCTION', 0x80030001, 'Unable to perform requested operation.')

    # (0x80030002) %1 could not be found.
    STG_E_FILENOTFOUND = HResultCode.new('STG_E_FILENOTFOUND', 0x80030002, '%1 could not be found.')

    # (0x80030003) The path %1 could not be found.
    STG_E_PATHNOTFOUND = HResultCode.new('STG_E_PATHNOTFOUND', 0x80030003, 'The path %1 could not be found.')

    # (0x80030004) There are insufficient resources to open another file.
    STG_E_TOOMANYOPENFILES = HResultCode.new('STG_E_TOOMANYOPENFILES', 0x80030004, 'There are insufficient resources to open another file.')

    # (0x80030005) Access denied.
    STG_E_ACCESSDENIED = HResultCode.new('STG_E_ACCESSDENIED', 0x80030005, 'Access denied.')

    # (0x80030006) Attempted an operation on an invalid object.
    STG_E_INVALIDHANDLE = HResultCode.new('STG_E_INVALIDHANDLE', 0x80030006, 'Attempted an operation on an invalid object.')

    # (0x80030008) There is insufficient memory available to complete operation.
    STG_E_INSUFFICIENTMEMORY = HResultCode.new('STG_E_INSUFFICIENTMEMORY', 0x80030008, 'There is insufficient memory available to complete operation.')

    # (0x80030009) Invalid pointer error.
    STG_E_INVALIDPOINTER = HResultCode.new('STG_E_INVALIDPOINTER', 0x80030009, 'Invalid pointer error.')

    # (0x80030012) There are no more entries to return.
    STG_E_NOMOREFILES = HResultCode.new('STG_E_NOMOREFILES', 0x80030012, 'There are no more entries to return.')

    # (0x80030013) Disk is write-protected.
    STG_E_DISKISWRITEPROTECTED = HResultCode.new('STG_E_DISKISWRITEPROTECTED', 0x80030013, 'Disk is write-protected.')

    # (0x80030019) An error occurred during a seek operation.
    STG_E_SEEKERROR = HResultCode.new('STG_E_SEEKERROR', 0x80030019, 'An error occurred during a seek operation.')

    # (0x8003001d) A disk error occurred during a write operation.
    STG_E_WRITEFAULT = HResultCode.new('STG_E_WRITEFAULT', 0x8003001d, 'A disk error occurred during a write operation.')

    # (0x8003001e) A disk error occurred during a read operation.
    STG_E_READFAULT = HResultCode.new('STG_E_READFAULT', 0x8003001e, 'A disk error occurred during a read operation.')

    # (0x80030020) A share violation has occurred.
    STG_E_SHAREVIOLATION = HResultCode.new('STG_E_SHAREVIOLATION', 0x80030020, 'A share violation has occurred.')

    # (0x80030021) A lock violation has occurred.
    STG_E_LOCKVIOLATION = HResultCode.new('STG_E_LOCKVIOLATION', 0x80030021, 'A lock violation has occurred.')

    # (0x80030050) %1 already exists.
    STG_E_FILEALREADYEXISTS = HResultCode.new('STG_E_FILEALREADYEXISTS', 0x80030050, '%1 already exists.')

    # (0x80030057) Invalid parameter error.
    STG_E_INVALIDPARAMETER = HResultCode.new('STG_E_INVALIDPARAMETER', 0x80030057, 'Invalid parameter error.')

    # (0x80030070) There is insufficient disk space to complete operation.
    STG_E_MEDIUMFULL = HResultCode.new('STG_E_MEDIUMFULL', 0x80030070, 'There is insufficient disk space to complete operation.')

    # (0x800300f0) Illegal write of non-simple property to simple property set.
    STG_E_PROPSETMISMATCHED = HResultCode.new('STG_E_PROPSETMISMATCHED', 0x800300f0, 'Illegal write of non-simple property to simple property set.')

    # (0x800300fa) An application programming interface (API) call exited abnormally.
    STG_E_ABNORMALAPIEXIT = HResultCode.new('STG_E_ABNORMALAPIEXIT', 0x800300fa, 'An application programming interface (API) call exited abnormally.')

    # (0x800300fb) The file %1 is not a valid compound file.
    STG_E_INVALIDHEADER = HResultCode.new('STG_E_INVALIDHEADER', 0x800300fb, 'The file %1 is not a valid compound file.')

    # (0x800300fc) The name %1 is not valid.
    STG_E_INVALIDNAME = HResultCode.new('STG_E_INVALIDNAME', 0x800300fc, 'The name %1 is not valid.')

    # (0x800300fd) An unexpected error occurred.
    STG_E_UNKNOWN = HResultCode.new('STG_E_UNKNOWN', 0x800300fd, 'An unexpected error occurred.')

    # (0x800300fe) That function is not implemented.
    STG_E_UNIMPLEMENTEDFUNCTION = HResultCode.new('STG_E_UNIMPLEMENTEDFUNCTION', 0x800300fe, 'That function is not implemented.')

    # (0x800300ff) Invalid flag error.
    STG_E_INVALIDFLAG = HResultCode.new('STG_E_INVALIDFLAG', 0x800300ff, 'Invalid flag error.')

    # (0x80030100) Attempted to use an object that is busy.
    STG_E_INUSE = HResultCode.new('STG_E_INUSE', 0x80030100, 'Attempted to use an object that is busy.')

    # (0x80030101) The storage has been changed since the last commit.
    STG_E_NOTCURRENT = HResultCode.new('STG_E_NOTCURRENT', 0x80030101, 'The storage has been changed since the last commit.')

    # (0x80030102) Attempted to use an object that has ceased to exist.
    STG_E_REVERTED = HResultCode.new('STG_E_REVERTED', 0x80030102, 'Attempted to use an object that has ceased to exist.')

    # (0x80030103) Cannot save.
    STG_E_CANTSAVE = HResultCode.new('STG_E_CANTSAVE', 0x80030103, 'Cannot save.')

    # (0x80030104) The compound file %1 was produced with an incompatible version of storage.
    STG_E_OLDFORMAT = HResultCode.new('STG_E_OLDFORMAT', 0x80030104, 'The compound file %1 was produced with an incompatible version of storage.')

    # (0x80030105) The compound file %1 was produced with a newer version of storage.
    STG_E_OLDDLL = HResultCode.new('STG_E_OLDDLL', 0x80030105, 'The compound file %1 was produced with a newer version of storage.')

    # (0x80030106) Share.exe or equivalent is required for operation.
    STG_E_SHAREREQUIRED = HResultCode.new('STG_E_SHAREREQUIRED', 0x80030106, 'Share.exe or equivalent is required for operation.')

    # (0x80030107) Illegal operation called on non-file based storage.
    STG_E_NOTFILEBASEDSTORAGE = HResultCode.new('STG_E_NOTFILEBASEDSTORAGE', 0x80030107, 'Illegal operation called on non-file based storage.')

    # (0x80030108) Illegal operation called on object with extant marshalings.
    STG_E_EXTANTMARSHALLINGS = HResultCode.new('STG_E_EXTANTMARSHALLINGS', 0x80030108, 'Illegal operation called on object with extant marshalings.')

    # (0x80030109) The docfile has been corrupted.
    STG_E_DOCFILECORRUPT = HResultCode.new('STG_E_DOCFILECORRUPT', 0x80030109, 'The docfile has been corrupted.')

    # (0x80030110) OLE32.DLL has been loaded at the wrong address.
    STG_E_BADBASEADDRESS = HResultCode.new('STG_E_BADBASEADDRESS', 0x80030110, 'OLE32.DLL has been loaded at the wrong address.')

    # (0x80030111) The compound file is too large for the current implementation.
    STG_E_DOCFILETOOLARGE = HResultCode.new('STG_E_DOCFILETOOLARGE', 0x80030111, 'The compound file is too large for the current implementation.')

    # (0x80030112) The compound file was not created with the STGM_SIMPLE flag.
    STG_E_NOTSIMPLEFORMAT = HResultCode.new('STG_E_NOTSIMPLEFORMAT', 0x80030112, 'The compound file was not created with the STGM_SIMPLE flag.')

    # (0x80030201) The file download was aborted abnormally. The file is incomplete.
    STG_E_INCOMPLETE = HResultCode.new('STG_E_INCOMPLETE', 0x80030201, 'The file download was aborted abnormally. The file is incomplete.')

    # (0x80030202) The file download has been terminated.
    STG_E_TERMINATED = HResultCode.new('STG_E_TERMINATED', 0x80030202, 'The file download has been terminated.')

    # (0x80030305) Generic Copy Protection Error.
    STG_E_STATUS_COPY_PROTECTION_FAILURE = HResultCode.new('STG_E_STATUS_COPY_PROTECTION_FAILURE', 0x80030305, 'Generic Copy Protection Error.')

    # (0x80030306) Copy Protection Error—DVD CSS Authentication failed.
    STG_E_CSS_AUTHENTICATION_FAILURE = HResultCode.new('STG_E_CSS_AUTHENTICATION_FAILURE', 0x80030306, 'Copy Protection Error—DVD CSS Authentication failed.')

    # (0x80030307) Copy Protection Error—The given sector does not have a valid CSS key.
    STG_E_CSS_KEY_NOT_PRESENT = HResultCode.new('STG_E_CSS_KEY_NOT_PRESENT', 0x80030307, 'Copy Protection Error—The given sector does not have a valid CSS key.')

    # (0x80030308) Copy Protection Error—DVD session key not established.
    STG_E_CSS_KEY_NOT_ESTABLISHED = HResultCode.new('STG_E_CSS_KEY_NOT_ESTABLISHED', 0x80030308, 'Copy Protection Error—DVD session key not established.')

    # (0x80030309) Copy Protection Error—The read failed because the sector is encrypted.
    STG_E_CSS_SCRAMBLED_SECTOR = HResultCode.new('STG_E_CSS_SCRAMBLED_SECTOR', 0x80030309, 'Copy Protection Error—The read failed because the sector is encrypted.')

    # (0x8003030a) Copy Protection Error—The current DVD's region does not correspond to the region setting of the drive.
    STG_E_CSS_REGION_MISMATCH = HResultCode.new('STG_E_CSS_REGION_MISMATCH', 0x8003030a, 'Copy Protection Error—The current DVD\'s region does not correspond to the region setting of the drive.')

    # (0x8003030b) Copy Protection Error—The drive's region setting might be permanent or the number of user resets has been exhausted.
    STG_E_RESETS_EXHAUSTED = HResultCode.new('STG_E_RESETS_EXHAUSTED', 0x8003030b, 'Copy Protection Error—The drive\'s region setting might be permanent or the number of user resets has been exhausted.')

    # (0x80040000) Invalid OLEVERB structure.
    OLE_E_OLEVERB = HResultCode.new('OLE_E_OLEVERB', 0x80040000, 'Invalid OLEVERB structure.')

    # (0x80040001) Invalid advise flags.
    OLE_E_ADVF = HResultCode.new('OLE_E_ADVF', 0x80040001, 'Invalid advise flags.')

    # (0x80040002) Cannot enumerate any more because the associated data is missing.
    OLE_E_ENUM_NOMORE = HResultCode.new('OLE_E_ENUM_NOMORE', 0x80040002, 'Cannot enumerate any more because the associated data is missing.')

    # (0x80040003) This implementation does not take advises.
    OLE_E_ADVISENOTSUPPORTED = HResultCode.new('OLE_E_ADVISENOTSUPPORTED', 0x80040003, 'This implementation does not take advises.')

    # (0x80040004) There is no connection for this connection ID.
    OLE_E_NOCONNECTION = HResultCode.new('OLE_E_NOCONNECTION', 0x80040004, 'There is no connection for this connection ID.')

    # (0x80040005) Need to run the object to perform this operation.
    OLE_E_NOTRUNNING = HResultCode.new('OLE_E_NOTRUNNING', 0x80040005, 'Need to run the object to perform this operation.')

    # (0x80040006) There is no cache to operate on.
    OLE_E_NOCACHE = HResultCode.new('OLE_E_NOCACHE', 0x80040006, 'There is no cache to operate on.')

    # (0x80040007) Uninitialized object.
    OLE_E_BLANK = HResultCode.new('OLE_E_BLANK', 0x80040007, 'Uninitialized object.')

    # (0x80040008) Linked object's source class has changed.
    OLE_E_CLASSDIFF = HResultCode.new('OLE_E_CLASSDIFF', 0x80040008, 'Linked object\'s source class has changed.')

    # (0x80040009) Not able to get the moniker of the object.
    OLE_E_CANT_GETMONIKER = HResultCode.new('OLE_E_CANT_GETMONIKER', 0x80040009, 'Not able to get the moniker of the object.')

    # (0x8004000a) Not able to bind to the source.
    OLE_E_CANT_BINDTOSOURCE = HResultCode.new('OLE_E_CANT_BINDTOSOURCE', 0x8004000a, 'Not able to bind to the source.')

    # (0x8004000b) Object is static; operation not allowed.
    OLE_E_STATIC = HResultCode.new('OLE_E_STATIC', 0x8004000b, 'Object is static; operation not allowed.')

    # (0x8004000c) User canceled out of the Save dialog box.
    OLE_E_PROMPTSAVECANCELLED = HResultCode.new('OLE_E_PROMPTSAVECANCELLED', 0x8004000c, 'User canceled out of the Save dialog box.')

    # (0x8004000d) Invalid rectangle.
    OLE_E_INVALIDRECT = HResultCode.new('OLE_E_INVALIDRECT', 0x8004000d, 'Invalid rectangle.')

    # (0x8004000e) compobj.dll is too old for the ole2.dll initialized.
    OLE_E_WRONGCOMPOBJ = HResultCode.new('OLE_E_WRONGCOMPOBJ', 0x8004000e, 'compobj.dll is too old for the ole2.dll initialized.')

    # (0x8004000f) Invalid window handle.
    OLE_E_INVALIDHWND = HResultCode.new('OLE_E_INVALIDHWND', 0x8004000f, 'Invalid window handle.')

    # (0x80040010) Object is not in any of the inplace active states.
    OLE_E_NOT_INPLACEACTIVE = HResultCode.new('OLE_E_NOT_INPLACEACTIVE', 0x80040010, 'Object is not in any of the inplace active states.')

    # (0x80040011) Not able to convert object.
    OLE_E_CANTCONVERT = HResultCode.new('OLE_E_CANTCONVERT', 0x80040011, 'Not able to convert object.')

    # (0x80040012) Not able to perform the operation because object is not given storage yet.
    OLE_E_NOSTORAGE = HResultCode.new('OLE_E_NOSTORAGE', 0x80040012, 'Not able to perform the operation because object is not given storage yet.')

    # (0x80040064) Invalid FORMATETC structure.
    DV_E_FORMATETC = HResultCode.new('DV_E_FORMATETC', 0x80040064, 'Invalid FORMATETC structure.')

    # (0x80040065) Invalid DVTARGETDEVICE structure.
    DV_E_DVTARGETDEVICE = HResultCode.new('DV_E_DVTARGETDEVICE', 0x80040065, 'Invalid DVTARGETDEVICE structure.')

    # (0x80040066) Invalid STDGMEDIUM structure.
    DV_E_STGMEDIUM = HResultCode.new('DV_E_STGMEDIUM', 0x80040066, 'Invalid STDGMEDIUM structure.')

    # (0x80040067) Invalid STATDATA structure.
    DV_E_STATDATA = HResultCode.new('DV_E_STATDATA', 0x80040067, 'Invalid STATDATA structure.')

    # (0x80040068) Invalid lindex.
    DV_E_LINDEX = HResultCode.new('DV_E_LINDEX', 0x80040068, 'Invalid lindex.')

    # (0x80040069) Invalid TYMED structure.
    DV_E_TYMED = HResultCode.new('DV_E_TYMED', 0x80040069, 'Invalid TYMED structure.')

    # (0x8004006a) Invalid clipboard format.
    DV_E_CLIPFORMAT = HResultCode.new('DV_E_CLIPFORMAT', 0x8004006a, 'Invalid clipboard format.')

    # (0x8004006b) Invalid aspects.
    DV_E_DVASPECT = HResultCode.new('DV_E_DVASPECT', 0x8004006b, 'Invalid aspects.')

    # (0x8004006c) The tdSize parameter of the DVTARGETDEVICE structure is invalid.
    DV_E_DVTARGETDEVICE_SIZE = HResultCode.new('DV_E_DVTARGETDEVICE_SIZE', 0x8004006c, 'The tdSize parameter of the DVTARGETDEVICE structure is invalid.')

    # (0x8004006d) Object does not support IViewObject interface.
    DV_E_NOIVIEWOBJECT = HResultCode.new('DV_E_NOIVIEWOBJECT', 0x8004006d, 'Object does not support IViewObject interface.')

    # (0x80040100) Trying to revoke a drop target that has not been registered.
    DRAGDROP_E_NOTREGISTERED = HResultCode.new('DRAGDROP_E_NOTREGISTERED', 0x80040100, 'Trying to revoke a drop target that has not been registered.')

    # (0x80040101) This window has already been registered as a drop target.
    DRAGDROP_E_ALREADYREGISTERED = HResultCode.new('DRAGDROP_E_ALREADYREGISTERED', 0x80040101, 'This window has already been registered as a drop target.')

    # (0x80040102) Invalid window handle.
    DRAGDROP_E_INVALIDHWND = HResultCode.new('DRAGDROP_E_INVALIDHWND', 0x80040102, 'Invalid window handle.')

    # (0x80040110) Class does not support aggregation (or class object is remote).
    CLASS_E_NOAGGREGATION = HResultCode.new('CLASS_E_NOAGGREGATION', 0x80040110, 'Class does not support aggregation (or class object is remote).')

    # (0x80040111) ClassFactory cannot supply requested class.
    CLASS_E_CLASSNOTAVAILABLE = HResultCode.new('CLASS_E_CLASSNOTAVAILABLE', 0x80040111, 'ClassFactory cannot supply requested class.')

    # (0x80040112) Class is not licensed for use.
    CLASS_E_NOTLICENSED = HResultCode.new('CLASS_E_NOTLICENSED', 0x80040112, 'Class is not licensed for use.')

    # (0x80040140) Error drawing view.
    VIEW_E_DRAW = HResultCode.new('VIEW_E_DRAW', 0x80040140, 'Error drawing view.')

    # (0x80040150) Could not read key from registry.
    REGDB_E_READREGDB = HResultCode.new('REGDB_E_READREGDB', 0x80040150, 'Could not read key from registry.')

    # (0x80040151) Could not write key to registry.
    REGDB_E_WRITEREGDB = HResultCode.new('REGDB_E_WRITEREGDB', 0x80040151, 'Could not write key to registry.')

    # (0x80040152) Could not find the key in the registry.
    REGDB_E_KEYMISSING = HResultCode.new('REGDB_E_KEYMISSING', 0x80040152, 'Could not find the key in the registry.')

    # (0x80040153) Invalid value for registry.
    REGDB_E_INVALIDVALUE = HResultCode.new('REGDB_E_INVALIDVALUE', 0x80040153, 'Invalid value for registry.')

    # (0x80040154) Class not registered.
    REGDB_E_CLASSNOTREG = HResultCode.new('REGDB_E_CLASSNOTREG', 0x80040154, 'Class not registered.')

    # (0x80040155) Interface not registered.
    REGDB_E_IIDNOTREG = HResultCode.new('REGDB_E_IIDNOTREG', 0x80040155, 'Interface not registered.')

    # (0x80040156) Threading model entry is not valid.
    REGDB_E_BADTHREADINGMODEL = HResultCode.new('REGDB_E_BADTHREADINGMODEL', 0x80040156, 'Threading model entry is not valid.')

    # (0x80040160) CATID does not exist.
    CAT_E_CATIDNOEXIST = HResultCode.new('CAT_E_CATIDNOEXIST', 0x80040160, 'CATID does not exist.')

    # (0x80040161) Description not found.
    CAT_E_NODESCRIPTION = HResultCode.new('CAT_E_NODESCRIPTION', 0x80040161, 'Description not found.')

    # (0x80040164) No package in the software installation data in Active Directory meets this criteria.
    CS_E_PACKAGE_NOTFOUND = HResultCode.new('CS_E_PACKAGE_NOTFOUND', 0x80040164, 'No package in the software installation data in Active Directory meets this criteria.')

    # (0x80040165) Deleting this will break the referential integrity of the software installation data in Active Directory.
    CS_E_NOT_DELETABLE = HResultCode.new('CS_E_NOT_DELETABLE', 0x80040165, 'Deleting this will break the referential integrity of the software installation data in Active Directory.')

    # (0x80040166) The CLSID was not found in the software installation data in Active Directory.
    CS_E_CLASS_NOTFOUND = HResultCode.new('CS_E_CLASS_NOTFOUND', 0x80040166, 'The CLSID was not found in the software installation data in Active Directory.')

    # (0x80040167) The software installation data in Active Directory is corrupt.
    CS_E_INVALID_VERSION = HResultCode.new('CS_E_INVALID_VERSION', 0x80040167, 'The software installation data in Active Directory is corrupt.')

    # (0x80040168) There is no software installation data in Active Directory.
    CS_E_NO_CLASSSTORE = HResultCode.new('CS_E_NO_CLASSSTORE', 0x80040168, 'There is no software installation data in Active Directory.')

    # (0x80040169) There is no software installation data object in Active Directory.
    CS_E_OBJECT_NOTFOUND = HResultCode.new('CS_E_OBJECT_NOTFOUND', 0x80040169, 'There is no software installation data object in Active Directory.')

    # (0x8004016a) The software installation data object in Active Directory already exists.
    CS_E_OBJECT_ALREADY_EXISTS = HResultCode.new('CS_E_OBJECT_ALREADY_EXISTS', 0x8004016a, 'The software installation data object in Active Directory already exists.')

    # (0x8004016b) The path to the software installation data in Active Directory is not correct.
    CS_E_INVALID_PATH = HResultCode.new('CS_E_INVALID_PATH', 0x8004016b, 'The path to the software installation data in Active Directory is not correct.')

    # (0x8004016c) A network error interrupted the operation.
    CS_E_NETWORK_ERROR = HResultCode.new('CS_E_NETWORK_ERROR', 0x8004016c, 'A network error interrupted the operation.')

    # (0x8004016d) The size of this object exceeds the maximum size set by the administrator.
    CS_E_ADMIN_LIMIT_EXCEEDED = HResultCode.new('CS_E_ADMIN_LIMIT_EXCEEDED', 0x8004016d, 'The size of this object exceeds the maximum size set by the administrator.')

    # (0x8004016e) The schema for the software installation data in Active Directory does not match the required schema.
    CS_E_SCHEMA_MISMATCH = HResultCode.new('CS_E_SCHEMA_MISMATCH', 0x8004016e, 'The schema for the software installation data in Active Directory does not match the required schema.')

    # (0x8004016f) An error occurred in the software installation data in Active Directory.
    CS_E_INTERNAL_ERROR = HResultCode.new('CS_E_INTERNAL_ERROR', 0x8004016f, 'An error occurred in the software installation data in Active Directory.')

    # (0x80040170) Cache not updated.
    CACHE_E_NOCACHE_UPDATED = HResultCode.new('CACHE_E_NOCACHE_UPDATED', 0x80040170, 'Cache not updated.')

    # (0x80040180) No verbs for OLE object.
    OLEOBJ_E_NOVERBS = HResultCode.new('OLEOBJ_E_NOVERBS', 0x80040180, 'No verbs for OLE object.')

    # (0x80040181) Invalid verb for OLE object.
    OLEOBJ_E_INVALIDVERB = HResultCode.new('OLEOBJ_E_INVALIDVERB', 0x80040181, 'Invalid verb for OLE object.')

    # (0x800401a0) Undo is not available.
    INPLACE_E_NOTUNDOABLE = HResultCode.new('INPLACE_E_NOTUNDOABLE', 0x800401a0, 'Undo is not available.')

    # (0x800401a1) Space for tools is not available.
    INPLACE_E_NOTOOLSPACE = HResultCode.new('INPLACE_E_NOTOOLSPACE', 0x800401a1, 'Space for tools is not available.')

    # (0x800401c0) OLESTREAM Get method failed.
    CONVERT10_E_OLESTREAM_GET = HResultCode.new('CONVERT10_E_OLESTREAM_GET', 0x800401c0, 'OLESTREAM Get method failed.')

    # (0x800401c1) OLESTREAM Put method failed.
    CONVERT10_E_OLESTREAM_PUT = HResultCode.new('CONVERT10_E_OLESTREAM_PUT', 0x800401c1, 'OLESTREAM Put method failed.')

    # (0x800401c2) Contents of the OLESTREAM not in correct format.
    CONVERT10_E_OLESTREAM_FMT = HResultCode.new('CONVERT10_E_OLESTREAM_FMT', 0x800401c2, 'Contents of the OLESTREAM not in correct format.')

    # (0x800401c3) There was an error in a Windows GDI call while converting the bitmap to a device-independent bitmap (DIB).
    CONVERT10_E_OLESTREAM_BITMAP_TO_DIB = HResultCode.new('CONVERT10_E_OLESTREAM_BITMAP_TO_DIB', 0x800401c3, 'There was an error in a Windows GDI call while converting the bitmap to a device-independent bitmap (DIB).')

    # (0x800401c4) Contents of the IStorage not in correct format.
    CONVERT10_E_STG_FMT = HResultCode.new('CONVERT10_E_STG_FMT', 0x800401c4, 'Contents of the IStorage not in correct format.')

    # (0x800401c5) Contents of IStorage is missing one of the standard streams.
    CONVERT10_E_STG_NO_STD_STREAM = HResultCode.new('CONVERT10_E_STG_NO_STD_STREAM', 0x800401c5, 'Contents of IStorage is missing one of the standard streams.')

    # (0x800401c6) There was an error in a Windows Graphics Device Interface (GDI) call while converting the DIB to a bitmap.
    CONVERT10_E_STG_DIB_TO_BITMAP = HResultCode.new('CONVERT10_E_STG_DIB_TO_BITMAP', 0x800401c6, 'There was an error in a Windows Graphics Device Interface (GDI) call while converting the DIB to a bitmap.')

    # (0x800401d0) OpenClipboard failed.
    CLIPBRD_E_CANT_OPEN = HResultCode.new('CLIPBRD_E_CANT_OPEN', 0x800401d0, 'OpenClipboard failed.')

    # (0x800401d1) EmptyClipboard failed.
    CLIPBRD_E_CANT_EMPTY = HResultCode.new('CLIPBRD_E_CANT_EMPTY', 0x800401d1, 'EmptyClipboard failed.')

    # (0x800401d2) SetClipboard failed.
    CLIPBRD_E_CANT_SET = HResultCode.new('CLIPBRD_E_CANT_SET', 0x800401d2, 'SetClipboard failed.')

    # (0x800401d3) Data on clipboard is invalid.
    CLIPBRD_E_BAD_DATA = HResultCode.new('CLIPBRD_E_BAD_DATA', 0x800401d3, 'Data on clipboard is invalid.')

    # (0x800401d4) CloseClipboard failed.
    CLIPBRD_E_CANT_CLOSE = HResultCode.new('CLIPBRD_E_CANT_CLOSE', 0x800401d4, 'CloseClipboard failed.')

    # (0x800401e0) Moniker needs to be connected manually.
    MK_E_CONNECTMANUALLY = HResultCode.new('MK_E_CONNECTMANUALLY', 0x800401e0, 'Moniker needs to be connected manually.')

    # (0x800401e1) Operation exceeded deadline.
    MK_E_EXCEEDEDDEADLINE = HResultCode.new('MK_E_EXCEEDEDDEADLINE', 0x800401e1, 'Operation exceeded deadline.')

    # (0x800401e2) Moniker needs to be generic.
    MK_E_NEEDGENERIC = HResultCode.new('MK_E_NEEDGENERIC', 0x800401e2, 'Moniker needs to be generic.')

    # (0x800401e3) Operation unavailable.
    MK_E_UNAVAILABLE = HResultCode.new('MK_E_UNAVAILABLE', 0x800401e3, 'Operation unavailable.')

    # (0x800401e4) Invalid syntax.
    MK_E_SYNTAX = HResultCode.new('MK_E_SYNTAX', 0x800401e4, 'Invalid syntax.')

    # (0x800401e5) No object for moniker.
    MK_E_NOOBJECT = HResultCode.new('MK_E_NOOBJECT', 0x800401e5, 'No object for moniker.')

    # (0x800401e6) Bad extension for file.
    MK_E_INVALIDEXTENSION = HResultCode.new('MK_E_INVALIDEXTENSION', 0x800401e6, 'Bad extension for file.')

    # (0x800401e7) Intermediate operation failed.
    MK_E_INTERMEDIATEINTERFACENOTSUPPORTED = HResultCode.new('MK_E_INTERMEDIATEINTERFACENOTSUPPORTED', 0x800401e7, 'Intermediate operation failed.')

    # (0x800401e8) Moniker is not bindable.
    MK_E_NOTBINDABLE = HResultCode.new('MK_E_NOTBINDABLE', 0x800401e8, 'Moniker is not bindable.')

    # (0x800401e9) Moniker is not bound.
    MK_E_NOTBOUND = HResultCode.new('MK_E_NOTBOUND', 0x800401e9, 'Moniker is not bound.')

    # (0x800401ea) Moniker cannot open file.
    MK_E_CANTOPENFILE = HResultCode.new('MK_E_CANTOPENFILE', 0x800401ea, 'Moniker cannot open file.')

    # (0x800401eb) User input required for operation to succeed.
    MK_E_MUSTBOTHERUSER = HResultCode.new('MK_E_MUSTBOTHERUSER', 0x800401eb, 'User input required for operation to succeed.')

    # (0x800401ec) Moniker class has no inverse.
    MK_E_NOINVERSE = HResultCode.new('MK_E_NOINVERSE', 0x800401ec, 'Moniker class has no inverse.')

    # (0x800401ed) Moniker does not refer to storage.
    MK_E_NOSTORAGE = HResultCode.new('MK_E_NOSTORAGE', 0x800401ed, 'Moniker does not refer to storage.')

    # (0x800401ee) No common prefix.
    MK_E_NOPREFIX = HResultCode.new('MK_E_NOPREFIX', 0x800401ee, 'No common prefix.')

    # (0x800401ef) Moniker could not be enumerated.
    MK_E_ENUMERATION_FAILED = HResultCode.new('MK_E_ENUMERATION_FAILED', 0x800401ef, 'Moniker could not be enumerated.')

    # (0x800401f0) CoInitialize has not been called.
    CO_E_NOTINITIALIZED = HResultCode.new('CO_E_NOTINITIALIZED', 0x800401f0, 'CoInitialize has not been called.')

    # (0x800401f1) CoInitialize has already been called.
    CO_E_ALREADYINITIALIZED = HResultCode.new('CO_E_ALREADYINITIALIZED', 0x800401f1, 'CoInitialize has already been called.')

    # (0x800401f2) Class of object cannot be determined.
    CO_E_CANTDETERMINECLASS = HResultCode.new('CO_E_CANTDETERMINECLASS', 0x800401f2, 'Class of object cannot be determined.')

    # (0x800401f3) Invalid class string.
    CO_E_CLASSSTRING = HResultCode.new('CO_E_CLASSSTRING', 0x800401f3, 'Invalid class string.')

    # (0x800401f4) Invalid interface string.
    CO_E_IIDSTRING = HResultCode.new('CO_E_IIDSTRING', 0x800401f4, 'Invalid interface string.')

    # (0x800401f5) Application not found.
    CO_E_APPNOTFOUND = HResultCode.new('CO_E_APPNOTFOUND', 0x800401f5, 'Application not found.')

    # (0x800401f6) Application cannot be run more than once.
    CO_E_APPSINGLEUSE = HResultCode.new('CO_E_APPSINGLEUSE', 0x800401f6, 'Application cannot be run more than once.')

    # (0x800401f7) Some error in application.
    CO_E_ERRORINAPP = HResultCode.new('CO_E_ERRORINAPP', 0x800401f7, 'Some error in application.')

    # (0x800401f8) DLL for class not found.
    CO_E_DLLNOTFOUND = HResultCode.new('CO_E_DLLNOTFOUND', 0x800401f8, 'DLL for class not found.')

    # (0x800401f9) Error in the DLL.
    CO_E_ERRORINDLL = HResultCode.new('CO_E_ERRORINDLL', 0x800401f9, 'Error in the DLL.')

    # (0x800401fa) Wrong operating system or operating system version for application.
    CO_E_WRONGOSFORAPP = HResultCode.new('CO_E_WRONGOSFORAPP', 0x800401fa, 'Wrong operating system or operating system version for application.')

    # (0x800401fb) Object is not registered.
    CO_E_OBJNOTREG = HResultCode.new('CO_E_OBJNOTREG', 0x800401fb, 'Object is not registered.')

    # (0x800401fc) Object is already registered.
    CO_E_OBJISREG = HResultCode.new('CO_E_OBJISREG', 0x800401fc, 'Object is already registered.')

    # (0x800401fd) Object is not connected to server.
    CO_E_OBJNOTCONNECTED = HResultCode.new('CO_E_OBJNOTCONNECTED', 0x800401fd, 'Object is not connected to server.')

    # (0x800401fe) Application was launched, but it did not register a class factory.
    CO_E_APPDIDNTREG = HResultCode.new('CO_E_APPDIDNTREG', 0x800401fe, 'Application was launched, but it did not register a class factory.')

    # (0x800401ff) Object has been released.
    CO_E_RELEASED = HResultCode.new('CO_E_RELEASED', 0x800401ff, 'Object has been released.')

    # (0x80040201) An event was unable to invoke any of the subscribers.
    EVENT_E_ALL_SUBSCRIBERS_FAILED = HResultCode.new('EVENT_E_ALL_SUBSCRIBERS_FAILED', 0x80040201, 'An event was unable to invoke any of the subscribers.')

    # (0x80040203) A syntax error occurred trying to evaluate a query string.
    EVENT_E_QUERYSYNTAX = HResultCode.new('EVENT_E_QUERYSYNTAX', 0x80040203, 'A syntax error occurred trying to evaluate a query string.')

    # (0x80040204) An invalid field name was used in a query string.
    EVENT_E_QUERYFIELD = HResultCode.new('EVENT_E_QUERYFIELD', 0x80040204, 'An invalid field name was used in a query string.')

    # (0x80040205) An unexpected exception was raised.
    EVENT_E_INTERNALEXCEPTION = HResultCode.new('EVENT_E_INTERNALEXCEPTION', 0x80040205, 'An unexpected exception was raised.')

    # (0x80040206) An unexpected internal error was detected.
    EVENT_E_INTERNALERROR = HResultCode.new('EVENT_E_INTERNALERROR', 0x80040206, 'An unexpected internal error was detected.')

    # (0x80040207) The owner security identifier (SID) on a per-user subscription does not exist.
    EVENT_E_INVALID_PER_USER_SID = HResultCode.new('EVENT_E_INVALID_PER_USER_SID', 0x80040207, 'The owner security identifier (SID) on a per-user subscription does not exist.')

    # (0x80040208) A user-supplied component or subscriber raised an exception.
    EVENT_E_USER_EXCEPTION = HResultCode.new('EVENT_E_USER_EXCEPTION', 0x80040208, 'A user-supplied component or subscriber raised an exception.')

    # (0x80040209) An interface has too many methods to fire events from.
    EVENT_E_TOO_MANY_METHODS = HResultCode.new('EVENT_E_TOO_MANY_METHODS', 0x80040209, 'An interface has too many methods to fire events from.')

    # (0x8004020a) A subscription cannot be stored unless its event class already exists.
    EVENT_E_MISSING_EVENTCLASS = HResultCode.new('EVENT_E_MISSING_EVENTCLASS', 0x8004020a, 'A subscription cannot be stored unless its event class already exists.')

    # (0x8004020b) Not all the objects requested could be removed.
    EVENT_E_NOT_ALL_REMOVED = HResultCode.new('EVENT_E_NOT_ALL_REMOVED', 0x8004020b, 'Not all the objects requested could be removed.')

    # (0x8004020c) COM+ is required for this operation, but it is not installed.
    EVENT_E_COMPLUS_NOT_INSTALLED = HResultCode.new('EVENT_E_COMPLUS_NOT_INSTALLED', 0x8004020c, 'COM+ is required for this operation, but it is not installed.')

    # (0x8004020d) Cannot modify or delete an object that was not added using the COM+ Administrative SDK.
    EVENT_E_CANT_MODIFY_OR_DELETE_UNCONFIGURED_OBJECT = HResultCode.new('EVENT_E_CANT_MODIFY_OR_DELETE_UNCONFIGURED_OBJECT', 0x8004020d, 'Cannot modify or delete an object that was not added using the COM+ Administrative SDK.')

    # (0x8004020e) Cannot modify or delete an object that was added using the COM+ Administrative SDK.
    EVENT_E_CANT_MODIFY_OR_DELETE_CONFIGURED_OBJECT = HResultCode.new('EVENT_E_CANT_MODIFY_OR_DELETE_CONFIGURED_OBJECT', 0x8004020e, 'Cannot modify or delete an object that was added using the COM+ Administrative SDK.')

    # (0x8004020f) The event class for this subscription is in an invalid partition.
    EVENT_E_INVALID_EVENT_CLASS_PARTITION = HResultCode.new('EVENT_E_INVALID_EVENT_CLASS_PARTITION', 0x8004020f, 'The event class for this subscription is in an invalid partition.')

    # (0x80040210) The owner of the PerUser subscription is not logged on to the system specified.
    EVENT_E_PER_USER_SID_NOT_LOGGED_ON = HResultCode.new('EVENT_E_PER_USER_SID_NOT_LOGGED_ON', 0x80040210, 'The owner of the PerUser subscription is not logged on to the system specified.')

    # (0x80041309) Trigger not found.
    SCHED_E_TRIGGER_NOT_FOUND = HResultCode.new('SCHED_E_TRIGGER_NOT_FOUND', 0x80041309, 'Trigger not found.')

    # (0x8004130a) One or more of the properties that are needed to run this task have not been set.
    SCHED_E_TASK_NOT_READY = HResultCode.new('SCHED_E_TASK_NOT_READY', 0x8004130a, 'One or more of the properties that are needed to run this task have not been set.')

    # (0x8004130b) There is no running instance of the task.
    SCHED_E_TASK_NOT_RUNNING = HResultCode.new('SCHED_E_TASK_NOT_RUNNING', 0x8004130b, 'There is no running instance of the task.')

    # (0x8004130c) The Task Scheduler service is not installed on this computer.
    SCHED_E_SERVICE_NOT_INSTALLED = HResultCode.new('SCHED_E_SERVICE_NOT_INSTALLED', 0x8004130c, 'The Task Scheduler service is not installed on this computer.')

    # (0x8004130d) The task object could not be opened.
    SCHED_E_CANNOT_OPEN_TASK = HResultCode.new('SCHED_E_CANNOT_OPEN_TASK', 0x8004130d, 'The task object could not be opened.')

    # (0x8004130e) The object is either an invalid task object or is not a task object.
    SCHED_E_INVALID_TASK = HResultCode.new('SCHED_E_INVALID_TASK', 0x8004130e, 'The object is either an invalid task object or is not a task object.')

    # (0x8004130f) No account information could be found in the Task Scheduler security database for the task indicated.
    SCHED_E_ACCOUNT_INFORMATION_NOT_SET = HResultCode.new('SCHED_E_ACCOUNT_INFORMATION_NOT_SET', 0x8004130f, 'No account information could be found in the Task Scheduler security database for the task indicated.')

    # (0x80041310) Unable to establish existence of the account specified.
    SCHED_E_ACCOUNT_NAME_NOT_FOUND = HResultCode.new('SCHED_E_ACCOUNT_NAME_NOT_FOUND', 0x80041310, 'Unable to establish existence of the account specified.')

    # (0x80041311) Corruption was detected in the Task Scheduler security database; the database has been reset.
    SCHED_E_ACCOUNT_DBASE_CORRUPT = HResultCode.new('SCHED_E_ACCOUNT_DBASE_CORRUPT', 0x80041311, 'Corruption was detected in the Task Scheduler security database; the database has been reset.')

    # (0x80041312) Task Scheduler security services are available only on Windows NT operating system.
    SCHED_E_NO_SECURITY_SERVICES = HResultCode.new('SCHED_E_NO_SECURITY_SERVICES', 0x80041312, 'Task Scheduler security services are available only on Windows NT operating system.')

    # (0x80041313) The task object version is either unsupported or invalid.
    SCHED_E_UNKNOWN_OBJECT_VERSION = HResultCode.new('SCHED_E_UNKNOWN_OBJECT_VERSION', 0x80041313, 'The task object version is either unsupported or invalid.')

    # (0x80041314) The task has been configured with an unsupported combination of account settings and run-time options.
    SCHED_E_UNSUPPORTED_ACCOUNT_OPTION = HResultCode.new('SCHED_E_UNSUPPORTED_ACCOUNT_OPTION', 0x80041314, 'The task has been configured with an unsupported combination of account settings and run-time options.')

    # (0x80041315) The Task Scheduler service is not running.
    SCHED_E_SERVICE_NOT_RUNNING = HResultCode.new('SCHED_E_SERVICE_NOT_RUNNING', 0x80041315, 'The Task Scheduler service is not running.')

    # (0x80041316) The task XML contains an unexpected node.
    SCHED_E_UNEXPECTEDNODE = HResultCode.new('SCHED_E_UNEXPECTEDNODE', 0x80041316, 'The task XML contains an unexpected node.')

    # (0x80041317) The task XML contains an element or attribute from an unexpected namespace.
    SCHED_E_NAMESPACE = HResultCode.new('SCHED_E_NAMESPACE', 0x80041317, 'The task XML contains an element or attribute from an unexpected namespace.')

    # (0x80041318) The task XML contains a value that is incorrectly formatted or out of range.
    SCHED_E_INVALIDVALUE = HResultCode.new('SCHED_E_INVALIDVALUE', 0x80041318, 'The task XML contains a value that is incorrectly formatted or out of range.')

    # (0x80041319) The task XML is missing a required element or attribute.
    SCHED_E_MISSINGNODE = HResultCode.new('SCHED_E_MISSINGNODE', 0x80041319, 'The task XML is missing a required element or attribute.')

    # (0x8004131a) The task XML is malformed.
    SCHED_E_MALFORMEDXML = HResultCode.new('SCHED_E_MALFORMEDXML', 0x8004131a, 'The task XML is malformed.')

    # (0x8004131d) The task XML contains too many nodes of the same type.
    SCHED_E_TOO_MANY_NODES = HResultCode.new('SCHED_E_TOO_MANY_NODES', 0x8004131d, 'The task XML contains too many nodes of the same type.')

    # (0x8004131e) The task cannot be started after the trigger's end boundary.
    SCHED_E_PAST_END_BOUNDARY = HResultCode.new('SCHED_E_PAST_END_BOUNDARY', 0x8004131e, 'The task cannot be started after the trigger\'s end boundary.')

    # (0x8004131f) An instance of this task is already running.
    SCHED_E_ALREADY_RUNNING = HResultCode.new('SCHED_E_ALREADY_RUNNING', 0x8004131f, 'An instance of this task is already running.')

    # (0x80041320) The task will not run because the user is not logged on.
    SCHED_E_USER_NOT_LOGGED_ON = HResultCode.new('SCHED_E_USER_NOT_LOGGED_ON', 0x80041320, 'The task will not run because the user is not logged on.')

    # (0x80041321) The task image is corrupt or has been tampered with.
    SCHED_E_INVALID_TASK_HASH = HResultCode.new('SCHED_E_INVALID_TASK_HASH', 0x80041321, 'The task image is corrupt or has been tampered with.')

    # (0x80041322) The Task Scheduler service is not available.
    SCHED_E_SERVICE_NOT_AVAILABLE = HResultCode.new('SCHED_E_SERVICE_NOT_AVAILABLE', 0x80041322, 'The Task Scheduler service is not available.')

    # (0x80041323) The Task Scheduler service is too busy to handle your request. Try again later.
    SCHED_E_SERVICE_TOO_BUSY = HResultCode.new('SCHED_E_SERVICE_TOO_BUSY', 0x80041323, 'The Task Scheduler service is too busy to handle your request. Try again later.')

    # (0x80041324) The Task Scheduler service attempted to run the task, but the task did not run due to one of the constraints in the task definition.
    SCHED_E_TASK_ATTEMPTED = HResultCode.new('SCHED_E_TASK_ATTEMPTED', 0x80041324, 'The Task Scheduler service attempted to run the task, but the task did not run due to one of the constraints in the task definition.')

    # (0x8004d000) Another single phase resource manager has already been enlisted in this transaction.
    XACT_E_ALREADYOTHERSINGLEPHASE = HResultCode.new('XACT_E_ALREADYOTHERSINGLEPHASE', 0x8004d000, 'Another single phase resource manager has already been enlisted in this transaction.')

    # (0x8004d001) A retaining commit or abort is not supported.
    XACT_E_CANTRETAIN = HResultCode.new('XACT_E_CANTRETAIN', 0x8004d001, 'A retaining commit or abort is not supported.')

    # (0x8004d002) The transaction failed to commit for an unknown reason. The transaction was aborted.
    XACT_E_COMMITFAILED = HResultCode.new('XACT_E_COMMITFAILED', 0x8004d002, 'The transaction failed to commit for an unknown reason. The transaction was aborted.')

    # (0x8004d003) Cannot call commit on this transaction object because the calling application did not initiate the transaction.
    XACT_E_COMMITPREVENTED = HResultCode.new('XACT_E_COMMITPREVENTED', 0x8004d003, 'Cannot call commit on this transaction object because the calling application did not initiate the transaction.')

    # (0x8004d004) Instead of committing, the resource heuristically aborted.
    XACT_E_HEURISTICABORT = HResultCode.new('XACT_E_HEURISTICABORT', 0x8004d004, 'Instead of committing, the resource heuristically aborted.')

    # (0x8004d005) Instead of aborting, the resource heuristically committed.
    XACT_E_HEURISTICCOMMIT = HResultCode.new('XACT_E_HEURISTICCOMMIT', 0x8004d005, 'Instead of aborting, the resource heuristically committed.')

    # (0x8004d006) Some of the states of the resource were committed while others were aborted, likely because of heuristic decisions.
    XACT_E_HEURISTICDAMAGE = HResultCode.new('XACT_E_HEURISTICDAMAGE', 0x8004d006, 'Some of the states of the resource were committed while others were aborted, likely because of heuristic decisions.')

    # (0x8004d007) Some of the states of the resource might have been committed while others were aborted, likely because of heuristic decisions.
    XACT_E_HEURISTICDANGER = HResultCode.new('XACT_E_HEURISTICDANGER', 0x8004d007, 'Some of the states of the resource might have been committed while others were aborted, likely because of heuristic decisions.')

    # (0x8004d008) The requested isolation level is not valid or supported.
    XACT_E_ISOLATIONLEVEL = HResultCode.new('XACT_E_ISOLATIONLEVEL', 0x8004d008, 'The requested isolation level is not valid or supported.')

    # (0x8004d009) The transaction manager does not support an asynchronous operation for this method.
    XACT_E_NOASYNC = HResultCode.new('XACT_E_NOASYNC', 0x8004d009, 'The transaction manager does not support an asynchronous operation for this method.')

    # (0x8004d00a) Unable to enlist in the transaction.
    XACT_E_NOENLIST = HResultCode.new('XACT_E_NOENLIST', 0x8004d00a, 'Unable to enlist in the transaction.')

    # (0x8004d00b) The requested semantics of retention of isolation across retaining commit and abort boundaries cannot be supported by this transaction implementation, or isoFlags was not equal to 0.
    XACT_E_NOISORETAIN = HResultCode.new('XACT_E_NOISORETAIN', 0x8004d00b, 'The requested semantics of retention of isolation across retaining commit and abort boundaries cannot be supported by this transaction implementation, or isoFlags was not equal to 0.')

    # (0x8004d00c) There is no resource presently associated with this enlistment.
    XACT_E_NORESOURCE = HResultCode.new('XACT_E_NORESOURCE', 0x8004d00c, 'There is no resource presently associated with this enlistment.')

    # (0x8004d00d) The transaction failed to commit due to the failure of optimistic concurrency control in at least one of the resource managers.
    XACT_E_NOTCURRENT = HResultCode.new('XACT_E_NOTCURRENT', 0x8004d00d, 'The transaction failed to commit due to the failure of optimistic concurrency control in at least one of the resource managers.')

    # (0x8004d00e) The transaction has already been implicitly or explicitly committed or aborted.
    XACT_E_NOTRANSACTION = HResultCode.new('XACT_E_NOTRANSACTION', 0x8004d00e, 'The transaction has already been implicitly or explicitly committed or aborted.')

    # (0x8004d00f) An invalid combination of flags was specified.
    XACT_E_NOTSUPPORTED = HResultCode.new('XACT_E_NOTSUPPORTED', 0x8004d00f, 'An invalid combination of flags was specified.')

    # (0x8004d010) The resource manager ID is not associated with this transaction or the transaction manager.
    XACT_E_UNKNOWNRMGRID = HResultCode.new('XACT_E_UNKNOWNRMGRID', 0x8004d010, 'The resource manager ID is not associated with this transaction or the transaction manager.')

    # (0x8004d011) This method was called in the wrong state.
    XACT_E_WRONGSTATE = HResultCode.new('XACT_E_WRONGSTATE', 0x8004d011, 'This method was called in the wrong state.')

    # (0x8004d012) The indicated unit of work does not match the unit of work expected by the resource manager.
    XACT_E_WRONGUOW = HResultCode.new('XACT_E_WRONGUOW', 0x8004d012, 'The indicated unit of work does not match the unit of work expected by the resource manager.')

    # (0x8004d013) An enlistment in a transaction already exists.
    XACT_E_XTIONEXISTS = HResultCode.new('XACT_E_XTIONEXISTS', 0x8004d013, 'An enlistment in a transaction already exists.')

    # (0x8004d014) An import object for the transaction could not be found.
    XACT_E_NOIMPORTOBJECT = HResultCode.new('XACT_E_NOIMPORTOBJECT', 0x8004d014, 'An import object for the transaction could not be found.')

    # (0x8004d015) The transaction cookie is invalid.
    XACT_E_INVALIDCOOKIE = HResultCode.new('XACT_E_INVALIDCOOKIE', 0x8004d015, 'The transaction cookie is invalid.')

    # (0x8004d016) The transaction status is in doubt. A communication failure occurred, or a transaction manager or resource manager has failed.
    XACT_E_INDOUBT = HResultCode.new('XACT_E_INDOUBT', 0x8004d016, 'The transaction status is in doubt. A communication failure occurred, or a transaction manager or resource manager has failed.')

    # (0x8004d017) A time-out was specified, but time-outs are not supported.
    XACT_E_NOTIMEOUT = HResultCode.new('XACT_E_NOTIMEOUT', 0x8004d017, 'A time-out was specified, but time-outs are not supported.')

    # (0x8004d018) The requested operation is already in progress for the transaction.
    XACT_E_ALREADYINPROGRESS = HResultCode.new('XACT_E_ALREADYINPROGRESS', 0x8004d018, 'The requested operation is already in progress for the transaction.')

    # (0x8004d019) The transaction has already been aborted.
    XACT_E_ABORTED = HResultCode.new('XACT_E_ABORTED', 0x8004d019, 'The transaction has already been aborted.')

    # (0x8004d01a) The Transaction Manager returned a log full error.
    XACT_E_LOGFULL = HResultCode.new('XACT_E_LOGFULL', 0x8004d01a, 'The Transaction Manager returned a log full error.')

    # (0x8004d01b) The transaction manager is not available.
    XACT_E_TMNOTAVAILABLE = HResultCode.new('XACT_E_TMNOTAVAILABLE', 0x8004d01b, 'The transaction manager is not available.')

    # (0x8004d01c) A connection with the transaction manager was lost.
    XACT_E_CONNECTION_DOWN = HResultCode.new('XACT_E_CONNECTION_DOWN', 0x8004d01c, 'A connection with the transaction manager was lost.')

    # (0x8004d01d) A request to establish a connection with the transaction manager was denied.
    XACT_E_CONNECTION_DENIED = HResultCode.new('XACT_E_CONNECTION_DENIED', 0x8004d01d, 'A request to establish a connection with the transaction manager was denied.')

    # (0x8004d01e) Resource manager reenlistment to determine transaction status timed out.
    XACT_E_REENLISTTIMEOUT = HResultCode.new('XACT_E_REENLISTTIMEOUT', 0x8004d01e, 'Resource manager reenlistment to determine transaction status timed out.')

    # (0x8004d01f) The transaction manager failed to establish a connection with another Transaction Internet Protocol (TIP) transaction manager.
    XACT_E_TIP_CONNECT_FAILED = HResultCode.new('XACT_E_TIP_CONNECT_FAILED', 0x8004d01f, 'The transaction manager failed to establish a connection with another Transaction Internet Protocol (TIP) transaction manager.')

    # (0x8004d020) The transaction manager encountered a protocol error with another TIP transaction manager.
    XACT_E_TIP_PROTOCOL_ERROR = HResultCode.new('XACT_E_TIP_PROTOCOL_ERROR', 0x8004d020, 'The transaction manager encountered a protocol error with another TIP transaction manager.')

    # (0x8004d021) The transaction manager could not propagate a transaction from another TIP transaction manager.
    XACT_E_TIP_PULL_FAILED = HResultCode.new('XACT_E_TIP_PULL_FAILED', 0x8004d021, 'The transaction manager could not propagate a transaction from another TIP transaction manager.')

    # (0x8004d022) The transaction manager on the destination machine is not available.
    XACT_E_DEST_TMNOTAVAILABLE = HResultCode.new('XACT_E_DEST_TMNOTAVAILABLE', 0x8004d022, 'The transaction manager on the destination machine is not available.')

    # (0x8004d023) The transaction manager has disabled its support for TIP.
    XACT_E_TIP_DISABLED = HResultCode.new('XACT_E_TIP_DISABLED', 0x8004d023, 'The transaction manager has disabled its support for TIP.')

    # (0x8004d024) The transaction manager has disabled its support for remote or network transactions.
    XACT_E_NETWORK_TX_DISABLED = HResultCode.new('XACT_E_NETWORK_TX_DISABLED', 0x8004d024, 'The transaction manager has disabled its support for remote or network transactions.')

    # (0x8004d025) The partner transaction manager has disabled its support for remote or network transactions.
    XACT_E_PARTNER_NETWORK_TX_DISABLED = HResultCode.new('XACT_E_PARTNER_NETWORK_TX_DISABLED', 0x8004d025, 'The partner transaction manager has disabled its support for remote or network transactions.')

    # (0x8004d026) The transaction manager has disabled its support for XA transactions.
    XACT_E_XA_TX_DISABLED = HResultCode.new('XACT_E_XA_TX_DISABLED', 0x8004d026, 'The transaction manager has disabled its support for XA transactions.')

    # (0x8004d027) Microsoft Distributed Transaction Coordinator (MSDTC) was unable to read its configuration information.
    XACT_E_UNABLE_TO_READ_DTC_CONFIG = HResultCode.new('XACT_E_UNABLE_TO_READ_DTC_CONFIG', 0x8004d027, 'Microsoft Distributed Transaction Coordinator (MSDTC) was unable to read its configuration information.')

    # (0x8004d028) MSDTC was unable to load the DTC proxy DLL.
    XACT_E_UNABLE_TO_LOAD_DTC_PROXY = HResultCode.new('XACT_E_UNABLE_TO_LOAD_DTC_PROXY', 0x8004d028, 'MSDTC was unable to load the DTC proxy DLL.')

    # (0x8004d029) The local transaction has aborted.
    XACT_E_ABORTING = HResultCode.new('XACT_E_ABORTING', 0x8004d029, 'The local transaction has aborted.')

    # (0x8004d080) The specified CRM clerk was not found. It might have completed before it could be held.
    XACT_E_CLERKNOTFOUND = HResultCode.new('XACT_E_CLERKNOTFOUND', 0x8004d080, 'The specified CRM clerk was not found. It might have completed before it could be held.')

    # (0x8004d081) The specified CRM clerk does not exist.
    XACT_E_CLERKEXISTS = HResultCode.new('XACT_E_CLERKEXISTS', 0x8004d081, 'The specified CRM clerk does not exist.')

    # (0x8004d082) Recovery of the CRM log file is still in progress.
    XACT_E_RECOVERYINPROGRESS = HResultCode.new('XACT_E_RECOVERYINPROGRESS', 0x8004d082, 'Recovery of the CRM log file is still in progress.')

    # (0x8004d083) The transaction has completed, and the log records have been discarded from the log file. They are no longer available.
    XACT_E_TRANSACTIONCLOSED = HResultCode.new('XACT_E_TRANSACTIONCLOSED', 0x8004d083, 'The transaction has completed, and the log records have been discarded from the log file. They are no longer available.')

    # (0x8004d084) lsnToRead is outside of the current limits of the log
    XACT_E_INVALIDLSN = HResultCode.new('XACT_E_INVALIDLSN', 0x8004d084, 'lsnToRead is outside of the current limits of the log')

    # (0x8004d085) The COM+ Compensating Resource Manager has records it wishes to replay.
    XACT_E_REPLAYREQUEST = HResultCode.new('XACT_E_REPLAYREQUEST', 0x8004d085, 'The COM+ Compensating Resource Manager has records it wishes to replay.')

    # (0x8004d100) The request to connect to the specified transaction coordinator was denied.
    XACT_E_CONNECTION_REQUEST_DENIED = HResultCode.new('XACT_E_CONNECTION_REQUEST_DENIED', 0x8004d100, 'The request to connect to the specified transaction coordinator was denied.')

    # (0x8004d101) The maximum number of enlistments for the specified transaction has been reached.
    XACT_E_TOOMANY_ENLISTMENTS = HResultCode.new('XACT_E_TOOMANY_ENLISTMENTS', 0x8004d101, 'The maximum number of enlistments for the specified transaction has been reached.')

    # (0x8004d102) A resource manager with the same identifier is already registered with the specified transaction coordinator.
    XACT_E_DUPLICATE_GUID = HResultCode.new('XACT_E_DUPLICATE_GUID', 0x8004d102, 'A resource manager with the same identifier is already registered with the specified transaction coordinator.')

    # (0x8004d103) The prepare request given was not eligible for single-phase optimizations.
    XACT_E_NOTSINGLEPHASE = HResultCode.new('XACT_E_NOTSINGLEPHASE', 0x8004d103, 'The prepare request given was not eligible for single-phase optimizations.')

    # (0x8004d104) RecoveryComplete has already been called for the given resource manager.
    XACT_E_RECOVERYALREADYDONE = HResultCode.new('XACT_E_RECOVERYALREADYDONE', 0x8004d104, 'RecoveryComplete has already been called for the given resource manager.')

    # (0x8004d105) The interface call made was incorrect for the current state of the protocol.
    XACT_E_PROTOCOL = HResultCode.new('XACT_E_PROTOCOL', 0x8004d105, 'The interface call made was incorrect for the current state of the protocol.')

    # (0x8004d106) The xa_open call failed for the XA resource.
    XACT_E_RM_FAILURE = HResultCode.new('XACT_E_RM_FAILURE', 0x8004d106, 'The xa_open call failed for the XA resource.')

    # (0x8004d107) The xa_recover call failed for the XA resource.
    XACT_E_RECOVERY_FAILED = HResultCode.new('XACT_E_RECOVERY_FAILED', 0x8004d107, 'The xa_recover call failed for the XA resource.')

    # (0x8004d108) The logical unit of work specified cannot be found.
    XACT_E_LU_NOT_FOUND = HResultCode.new('XACT_E_LU_NOT_FOUND', 0x8004d108, 'The logical unit of work specified cannot be found.')

    # (0x8004d109) The specified logical unit of work already exists.
    XACT_E_DUPLICATE_LU = HResultCode.new('XACT_E_DUPLICATE_LU', 0x8004d109, 'The specified logical unit of work already exists.')

    # (0x8004d10a) Subordinate creation failed. The specified logical unit of work was not connected.
    XACT_E_LU_NOT_CONNECTED = HResultCode.new('XACT_E_LU_NOT_CONNECTED', 0x8004d10a, 'Subordinate creation failed. The specified logical unit of work was not connected.')

    # (0x8004d10b) A transaction with the given identifier already exists.
    XACT_E_DUPLICATE_TRANSID = HResultCode.new('XACT_E_DUPLICATE_TRANSID', 0x8004d10b, 'A transaction with the given identifier already exists.')

    # (0x8004d10c) The resource is in use.
    XACT_E_LU_BUSY = HResultCode.new('XACT_E_LU_BUSY', 0x8004d10c, 'The resource is in use.')

    # (0x8004d10d) The LU Recovery process is down.
    XACT_E_LU_NO_RECOVERY_PROCESS = HResultCode.new('XACT_E_LU_NO_RECOVERY_PROCESS', 0x8004d10d, 'The LU Recovery process is down.')

    # (0x8004d10e) The remote session was lost.
    XACT_E_LU_DOWN = HResultCode.new('XACT_E_LU_DOWN', 0x8004d10e, 'The remote session was lost.')

    # (0x8004d10f) The resource is currently recovering.
    XACT_E_LU_RECOVERING = HResultCode.new('XACT_E_LU_RECOVERING', 0x8004d10f, 'The resource is currently recovering.')

    # (0x8004d110) There was a mismatch in driving recovery.
    XACT_E_LU_RECOVERY_MISMATCH = HResultCode.new('XACT_E_LU_RECOVERY_MISMATCH', 0x8004d110, 'There was a mismatch in driving recovery.')

    # (0x8004d111) An error occurred with the XA resource.
    XACT_E_RM_UNAVAILABLE = HResultCode.new('XACT_E_RM_UNAVAILABLE', 0x8004d111, 'An error occurred with the XA resource.')

    # (0x8004e002) The root transaction wanted to commit, but the transaction aborted.
    CONTEXT_E_ABORTED = HResultCode.new('CONTEXT_E_ABORTED', 0x8004e002, 'The root transaction wanted to commit, but the transaction aborted.')

    # (0x8004e003) The COM+ component on which the method call was made has a transaction that has already aborted or is in the process of aborting.
    CONTEXT_E_ABORTING = HResultCode.new('CONTEXT_E_ABORTING', 0x8004e003, 'The COM+ component on which the method call was made has a transaction that has already aborted or is in the process of aborting.')

    # (0x8004e004) There is no Microsoft Transaction Server (MTS) object context.
    CONTEXT_E_NOCONTEXT = HResultCode.new('CONTEXT_E_NOCONTEXT', 0x8004e004, 'There is no Microsoft Transaction Server (MTS) object context.')

    # (0x8004e005) The component is configured to use synchronization, and this method call would cause a deadlock to occur.
    CONTEXT_E_WOULD_DEADLOCK = HResultCode.new('CONTEXT_E_WOULD_DEADLOCK', 0x8004e005, 'The component is configured to use synchronization, and this method call would cause a deadlock to occur.')

    # (0x8004e006) The component is configured to use synchronization, and a thread has timed out waiting to enter the context.
    CONTEXT_E_SYNCH_TIMEOUT = HResultCode.new('CONTEXT_E_SYNCH_TIMEOUT', 0x8004e006, 'The component is configured to use synchronization, and a thread has timed out waiting to enter the context.')

    # (0x8004e007) You made a method call on a COM+ component that has a transaction that has already committed or aborted.
    CONTEXT_E_OLDREF = HResultCode.new('CONTEXT_E_OLDREF', 0x8004e007, 'You made a method call on a COM+ component that has a transaction that has already committed or aborted.')

    # (0x8004e00c) The specified role was not configured for the application.
    CONTEXT_E_ROLENOTFOUND = HResultCode.new('CONTEXT_E_ROLENOTFOUND', 0x8004e00c, 'The specified role was not configured for the application.')

    # (0x8004e00f) COM+ was unable to talk to the MSDTC.
    CONTEXT_E_TMNOTAVAILABLE = HResultCode.new('CONTEXT_E_TMNOTAVAILABLE', 0x8004e00f, 'COM+ was unable to talk to the MSDTC.')

    # (0x8004e021) An unexpected error occurred during COM+ activation.
    CO_E_ACTIVATIONFAILED = HResultCode.new('CO_E_ACTIVATIONFAILED', 0x8004e021, 'An unexpected error occurred during COM+ activation.')

    # (0x8004e022) COM+ activation failed. Check the event log for more information.
    CO_E_ACTIVATIONFAILED_EVENTLOGGED = HResultCode.new('CO_E_ACTIVATIONFAILED_EVENTLOGGED', 0x8004e022, 'COM+ activation failed. Check the event log for more information.')

    # (0x8004e023) COM+ activation failed due to a catalog or configuration error.
    CO_E_ACTIVATIONFAILED_CATALOGERROR = HResultCode.new('CO_E_ACTIVATIONFAILED_CATALOGERROR', 0x8004e023, 'COM+ activation failed due to a catalog or configuration error.')

    # (0x8004e024) COM+ activation failed because the activation could not be completed in the specified amount of time.
    CO_E_ACTIVATIONFAILED_TIMEOUT = HResultCode.new('CO_E_ACTIVATIONFAILED_TIMEOUT', 0x8004e024, 'COM+ activation failed because the activation could not be completed in the specified amount of time.')

    # (0x8004e025) COM+ activation failed because an initialization function failed. Check the event log for more information.
    CO_E_INITIALIZATIONFAILED = HResultCode.new('CO_E_INITIALIZATIONFAILED', 0x8004e025, 'COM+ activation failed because an initialization function failed. Check the event log for more information.')

    # (0x8004e026) The requested operation requires that just-in-time (JIT) be in the current context, and it is not.
    CONTEXT_E_NOJIT = HResultCode.new('CONTEXT_E_NOJIT', 0x8004e026, 'The requested operation requires that just-in-time (JIT) be in the current context, and it is not.')

    # (0x8004e027) The requested operation requires that the current context have a transaction, and it does not.
    CONTEXT_E_NOTRANSACTION = HResultCode.new('CONTEXT_E_NOTRANSACTION', 0x8004e027, 'The requested operation requires that the current context have a transaction, and it does not.')

    # (0x8004e028) The components threading model has changed after install into a COM+ application. Re-install component.
    CO_E_THREADINGMODEL_CHANGED = HResultCode.new('CO_E_THREADINGMODEL_CHANGED', 0x8004e028, 'The components threading model has changed after install into a COM+ application. Re-install component.')

    # (0x8004e029) Internet Information Services (IIS) intrinsics not available. Start your work with IIS.
    CO_E_NOIISINTRINSICS = HResultCode.new('CO_E_NOIISINTRINSICS', 0x8004e029, 'Internet Information Services (IIS) intrinsics not available. Start your work with IIS.')

    # (0x8004e02a) An attempt to write a cookie failed.
    CO_E_NOCOOKIES = HResultCode.new('CO_E_NOCOOKIES', 0x8004e02a, 'An attempt to write a cookie failed.')

    # (0x8004e02b) An attempt to use a database generated a database-specific error.
    CO_E_DBERROR = HResultCode.new('CO_E_DBERROR', 0x8004e02b, 'An attempt to use a database generated a database-specific error.')

    # (0x8004e02c) The COM+ component you created must use object pooling to work.
    CO_E_NOTPOOLED = HResultCode.new('CO_E_NOTPOOLED', 0x8004e02c, 'The COM+ component you created must use object pooling to work.')

    # (0x8004e02d) The COM+ component you created must use object construction to work correctly.
    CO_E_NOTCONSTRUCTED = HResultCode.new('CO_E_NOTCONSTRUCTED', 0x8004e02d, 'The COM+ component you created must use object construction to work correctly.')

    # (0x8004e02e) The COM+ component requires synchronization, and it is not configured for it.
    CO_E_NOSYNCHRONIZATION = HResultCode.new('CO_E_NOSYNCHRONIZATION', 0x8004e02e, 'The COM+ component requires synchronization, and it is not configured for it.')

    # (0x8004e02f) The TxIsolation Level property for the COM+ component being created is stronger than the TxIsolationLevel for the root.
    CO_E_ISOLEVELMISMATCH = HResultCode.new('CO_E_ISOLEVELMISMATCH', 0x8004e02f, 'The TxIsolation Level property for the COM+ component being created is stronger than the TxIsolationLevel for the root.')

    # (0x8004e030) The component attempted to make a cross-context call between invocations of EnterTransactionScope and ExitTransactionScope. This is not allowed. Cross-context calls cannot be made while inside a transaction scope.
    CO_E_CALL_OUT_OF_TX_SCOPE_NOT_ALLOWED = HResultCode.new('CO_E_CALL_OUT_OF_TX_SCOPE_NOT_ALLOWED', 0x8004e030, 'The component attempted to make a cross-context call between invocations of EnterTransactionScope and ExitTransactionScope. This is not allowed. Cross-context calls cannot be made while inside a transaction scope.')

    # (0x8004e031) The component made a call to EnterTransactionScope, but did not make a corresponding call to ExitTransactionScope before returning.
    CO_E_EXIT_TRANSACTION_SCOPE_NOT_CALLED = HResultCode.new('CO_E_EXIT_TRANSACTION_SCOPE_NOT_CALLED', 0x8004e031, 'The component made a call to EnterTransactionScope, but did not make a corresponding call to ExitTransactionScope before returning.')

    # (0x80070005) General access denied error.
    E_ACCESSDENIED = HResultCode.new('E_ACCESSDENIED', 0x80070005, 'General access denied error.')

    # (0x8007000e) The server does not have enough memory for the new channel.
    E_OUTOFMEMORY = HResultCode.new('E_OUTOFMEMORY', 0x8007000e, 'The server does not have enough memory for the new channel.')

    # (0x80070032) The server cannot support a client request for a dynamic virtual channel.
    ERROR_NOT_SUPPORTED = HResultCode.new('ERROR_NOT_SUPPORTED', 0x80070032, 'The server cannot support a client request for a dynamic virtual channel.')

    # (0x80070057) One or more arguments are invalid.
    E_INVALIDARG = HResultCode.new('E_INVALIDARG', 0x80070057, 'One or more arguments are invalid.')

    # (0x80070070) There is not enough space on the disk.
    ERROR_DISK_FULL = HResultCode.new('ERROR_DISK_FULL', 0x80070070, 'There is not enough space on the disk.')

    # (0x80080001) Attempt to create a class object failed.
    CO_E_CLASS_CREATE_FAILED = HResultCode.new('CO_E_CLASS_CREATE_FAILED', 0x80080001, 'Attempt to create a class object failed.')

    # (0x80080002) OLE service could not bind object.
    CO_E_SCM_ERROR = HResultCode.new('CO_E_SCM_ERROR', 0x80080002, 'OLE service could not bind object.')

    # (0x80080003) RPC communication failed with OLE service.
    CO_E_SCM_RPC_FAILURE = HResultCode.new('CO_E_SCM_RPC_FAILURE', 0x80080003, 'RPC communication failed with OLE service.')

    # (0x80080004) Bad path to object.
    CO_E_BAD_PATH = HResultCode.new('CO_E_BAD_PATH', 0x80080004, 'Bad path to object.')

    # (0x80080005) Server execution failed.
    CO_E_SERVER_EXEC_FAILURE = HResultCode.new('CO_E_SERVER_EXEC_FAILURE', 0x80080005, 'Server execution failed.')

    # (0x80080006) OLE service could not communicate with the object server.
    CO_E_OBJSRV_RPC_FAILURE = HResultCode.new('CO_E_OBJSRV_RPC_FAILURE', 0x80080006, 'OLE service could not communicate with the object server.')

    # (0x80080007) Moniker path could not be normalized.
    MK_E_NO_NORMALIZED = HResultCode.new('MK_E_NO_NORMALIZED', 0x80080007, 'Moniker path could not be normalized.')

    # (0x80080008) Object server is stopping when OLE service contacts it.
    CO_E_SERVER_STOPPING = HResultCode.new('CO_E_SERVER_STOPPING', 0x80080008, 'Object server is stopping when OLE service contacts it.')

    # (0x80080009) An invalid root block pointer was specified.
    MEM_E_INVALID_ROOT = HResultCode.new('MEM_E_INVALID_ROOT', 0x80080009, 'An invalid root block pointer was specified.')

    # (0x80080010) An allocation chain contained an invalid link pointer.
    MEM_E_INVALID_LINK = HResultCode.new('MEM_E_INVALID_LINK', 0x80080010, 'An allocation chain contained an invalid link pointer.')

    # (0x80080011) The requested allocation size was too large.
    MEM_E_INVALID_SIZE = HResultCode.new('MEM_E_INVALID_SIZE', 0x80080011, 'The requested allocation size was too large.')

    # (0x80080015) The activation requires a display name to be present under the class identifier (CLSID) key.
    CO_E_MISSING_DISPLAYNAME = HResultCode.new('CO_E_MISSING_DISPLAYNAME', 0x80080015, 'The activation requires a display name to be present under the class identifier (CLSID) key.')

    # (0x80080016) The activation requires that the RunAs value for the application is Activate As Activator.
    CO_E_RUNAS_VALUE_MUST_BE_AAA = HResultCode.new('CO_E_RUNAS_VALUE_MUST_BE_AAA', 0x80080016, 'The activation requires that the RunAs value for the application is Activate As Activator.')

    # (0x80080017) The class is not configured to support elevated activation.
    CO_E_ELEVATION_DISABLED = HResultCode.new('CO_E_ELEVATION_DISABLED', 0x80080017, 'The class is not configured to support elevated activation.')

    # (0x80090001) Bad UID.
    NTE_BAD_UID = HResultCode.new('NTE_BAD_UID', 0x80090001, 'Bad UID.')

    # (0x80090002) Bad hash.
    NTE_BAD_HASH = HResultCode.new('NTE_BAD_HASH', 0x80090002, 'Bad hash.')

    # (0x80090003) Bad key.
    NTE_BAD_KEY = HResultCode.new('NTE_BAD_KEY', 0x80090003, 'Bad key.')

    # (0x80090004) Bad length.
    NTE_BAD_LEN = HResultCode.new('NTE_BAD_LEN', 0x80090004, 'Bad length.')

    # (0x80090005) Bad data.
    NTE_BAD_DATA = HResultCode.new('NTE_BAD_DATA', 0x80090005, 'Bad data.')

    # (0x80090006) Invalid signature.
    NTE_BAD_SIGNATURE = HResultCode.new('NTE_BAD_SIGNATURE', 0x80090006, 'Invalid signature.')

    # (0x80090007) Bad version of provider.
    NTE_BAD_VER = HResultCode.new('NTE_BAD_VER', 0x80090007, 'Bad version of provider.')

    # (0x80090008) Invalid algorithm specified.
    NTE_BAD_ALGID = HResultCode.new('NTE_BAD_ALGID', 0x80090008, 'Invalid algorithm specified.')

    # (0x80090009) Invalid flags specified.
    NTE_BAD_FLAGS = HResultCode.new('NTE_BAD_FLAGS', 0x80090009, 'Invalid flags specified.')

    # (0x8009000a) Invalid type specified.
    NTE_BAD_TYPE = HResultCode.new('NTE_BAD_TYPE', 0x8009000a, 'Invalid type specified.')

    # (0x8009000b) Key not valid for use in specified state.
    NTE_BAD_KEY_STATE = HResultCode.new('NTE_BAD_KEY_STATE', 0x8009000b, 'Key not valid for use in specified state.')

    # (0x8009000c) Hash not valid for use in specified state.
    NTE_BAD_HASH_STATE = HResultCode.new('NTE_BAD_HASH_STATE', 0x8009000c, 'Hash not valid for use in specified state.')

    # (0x8009000d) Key does not exist.
    NTE_NO_KEY = HResultCode.new('NTE_NO_KEY', 0x8009000d, 'Key does not exist.')

    # (0x8009000e) Insufficient memory available for the operation.
    NTE_NO_MEMORY = HResultCode.new('NTE_NO_MEMORY', 0x8009000e, 'Insufficient memory available for the operation.')

    # (0x8009000f) Object already exists.
    NTE_EXISTS = HResultCode.new('NTE_EXISTS', 0x8009000f, 'Object already exists.')

    # (0x80090010) Access denied.
    NTE_PERM = HResultCode.new('NTE_PERM', 0x80090010, 'Access denied.')

    # (0x80090011) Object was not found.
    NTE_NOT_FOUND = HResultCode.new('NTE_NOT_FOUND', 0x80090011, 'Object was not found.')

    # (0x80090012) Data already encrypted.
    NTE_DOUBLE_ENCRYPT = HResultCode.new('NTE_DOUBLE_ENCRYPT', 0x80090012, 'Data already encrypted.')

    # (0x80090013) Invalid provider specified.
    NTE_BAD_PROVIDER = HResultCode.new('NTE_BAD_PROVIDER', 0x80090013, 'Invalid provider specified.')

    # (0x80090014) Invalid provider type specified.
    NTE_BAD_PROV_TYPE = HResultCode.new('NTE_BAD_PROV_TYPE', 0x80090014, 'Invalid provider type specified.')

    # (0x80090015) Provider's public key is invalid.
    NTE_BAD_PUBLIC_KEY = HResultCode.new('NTE_BAD_PUBLIC_KEY', 0x80090015, 'Provider\'s public key is invalid.')

    # (0x80090016) Key set does not exist.
    NTE_BAD_KEYSET = HResultCode.new('NTE_BAD_KEYSET', 0x80090016, 'Key set does not exist.')

    # (0x80090017) Provider type not defined.
    NTE_PROV_TYPE_NOT_DEF = HResultCode.new('NTE_PROV_TYPE_NOT_DEF', 0x80090017, 'Provider type not defined.')

    # (0x80090018) The provider type, as registered, is invalid.
    NTE_PROV_TYPE_ENTRY_BAD = HResultCode.new('NTE_PROV_TYPE_ENTRY_BAD', 0x80090018, 'The provider type, as registered, is invalid.')

    # (0x80090019) The key set is not defined.
    NTE_KEYSET_NOT_DEF = HResultCode.new('NTE_KEYSET_NOT_DEF', 0x80090019, 'The key set is not defined.')

    # (0x8009001a) The key set, as registered, is invalid.
    NTE_KEYSET_ENTRY_BAD = HResultCode.new('NTE_KEYSET_ENTRY_BAD', 0x8009001a, 'The key set, as registered, is invalid.')

    # (0x8009001b) Provider type does not match registered value.
    NTE_PROV_TYPE_NO_MATCH = HResultCode.new('NTE_PROV_TYPE_NO_MATCH', 0x8009001b, 'Provider type does not match registered value.')

    # (0x8009001c) The digital signature file is corrupt.
    NTE_SIGNATURE_FILE_BAD = HResultCode.new('NTE_SIGNATURE_FILE_BAD', 0x8009001c, 'The digital signature file is corrupt.')

    # (0x8009001d) Provider DLL failed to initialize correctly.
    NTE_PROVIDER_DLL_FAIL = HResultCode.new('NTE_PROVIDER_DLL_FAIL', 0x8009001d, 'Provider DLL failed to initialize correctly.')

    # (0x8009001e) Provider DLL could not be found.
    NTE_PROV_DLL_NOT_FOUND = HResultCode.new('NTE_PROV_DLL_NOT_FOUND', 0x8009001e, 'Provider DLL could not be found.')

    # (0x8009001f) The keyset parameter is invalid.
    NTE_BAD_KEYSET_PARAM = HResultCode.new('NTE_BAD_KEYSET_PARAM', 0x8009001f, 'The keyset parameter is invalid.')

    # (0x80090020) An internal error occurred.
    NTE_FAIL = HResultCode.new('NTE_FAIL', 0x80090020, 'An internal error occurred.')

    # (0x80090021) A base error occurred.
    NTE_SYS_ERR = HResultCode.new('NTE_SYS_ERR', 0x80090021, 'A base error occurred.')

    # (0x80090022) Provider could not perform the action because the context was acquired as silent.
    NTE_SILENT_CONTEXT = HResultCode.new('NTE_SILENT_CONTEXT', 0x80090022, 'Provider could not perform the action because the context was acquired as silent.')

    # (0x80090023) The security token does not have storage space available for an additional container.
    NTE_TOKEN_KEYSET_STORAGE_FULL = HResultCode.new('NTE_TOKEN_KEYSET_STORAGE_FULL', 0x80090023, 'The security token does not have storage space available for an additional container.')

    # (0x80090024) The profile for the user is a temporary profile.
    NTE_TEMPORARY_PROFILE = HResultCode.new('NTE_TEMPORARY_PROFILE', 0x80090024, 'The profile for the user is a temporary profile.')

    # (0x80090025) The key parameters could not be set because the configuration service provider (CSP) uses fixed parameters.
    NTE_FIXEDPARAMETER = HResultCode.new('NTE_FIXEDPARAMETER', 0x80090025, 'The key parameters could not be set because the configuration service provider (CSP) uses fixed parameters.')

    # (0x80090026) The supplied handle is invalid.
    NTE_INVALID_HANDLE = HResultCode.new('NTE_INVALID_HANDLE', 0x80090026, 'The supplied handle is invalid.')

    # (0x80090027) The parameter is incorrect.
    NTE_INVALID_PARAMETER = HResultCode.new('NTE_INVALID_PARAMETER', 0x80090027, 'The parameter is incorrect.')

    # (0x80090028) The buffer supplied to a function was too small.
    NTE_BUFFER_TOO_SMALL = HResultCode.new('NTE_BUFFER_TOO_SMALL', 0x80090028, 'The buffer supplied to a function was too small.')

    # (0x80090029) The requested operation is not supported.
    NTE_NOT_SUPPORTED = HResultCode.new('NTE_NOT_SUPPORTED', 0x80090029, 'The requested operation is not supported.')

    # (0x8009002a) No more data is available.
    NTE_NO_MORE_ITEMS = HResultCode.new('NTE_NO_MORE_ITEMS', 0x8009002a, 'No more data is available.')

    # (0x8009002b) The supplied buffers overlap incorrectly.
    NTE_BUFFERS_OVERLAP = HResultCode.new('NTE_BUFFERS_OVERLAP', 0x8009002b, 'The supplied buffers overlap incorrectly.')

    # (0x8009002c) The specified data could not be decrypted.
    NTE_DECRYPTION_FAILURE = HResultCode.new('NTE_DECRYPTION_FAILURE', 0x8009002c, 'The specified data could not be decrypted.')

    # (0x8009002d) An internal consistency check failed.
    NTE_INTERNAL_ERROR = HResultCode.new('NTE_INTERNAL_ERROR', 0x8009002d, 'An internal consistency check failed.')

    # (0x8009002e) This operation requires input from the user.
    NTE_UI_REQUIRED = HResultCode.new('NTE_UI_REQUIRED', 0x8009002e, 'This operation requires input from the user.')

    # (0x8009002f) The cryptographic provider does not support Hash Message Authentication Code (HMAC).
    NTE_HMAC_NOT_SUPPORTED = HResultCode.new('NTE_HMAC_NOT_SUPPORTED', 0x8009002f, 'The cryptographic provider does not support Hash Message Authentication Code (HMAC).')

    # (0x80090300) Not enough memory is available to complete this request.
    SEC_E_INSUFFICIENT_MEMORY = HResultCode.new('SEC_E_INSUFFICIENT_MEMORY', 0x80090300, 'Not enough memory is available to complete this request.')

    # (0x80090301) The handle specified is invalid.
    SEC_E_INVALID_HANDLE = HResultCode.new('SEC_E_INVALID_HANDLE', 0x80090301, 'The handle specified is invalid.')

    # (0x80090302) The function requested is not supported.
    SEC_E_UNSUPPORTED_FUNCTION = HResultCode.new('SEC_E_UNSUPPORTED_FUNCTION', 0x80090302, 'The function requested is not supported.')

    # (0x80090303) The specified target is unknown or unreachable.
    SEC_E_TARGET_UNKNOWN = HResultCode.new('SEC_E_TARGET_UNKNOWN', 0x80090303, 'The specified target is unknown or unreachable.')

    # (0x80090304) The Local Security Authority (LSA) cannot be contacted.
    SEC_E_INTERNAL_ERROR = HResultCode.new('SEC_E_INTERNAL_ERROR', 0x80090304, 'The Local Security Authority (LSA) cannot be contacted.')

    # (0x80090305) The requested security package does not exist.
    SEC_E_SECPKG_NOT_FOUND = HResultCode.new('SEC_E_SECPKG_NOT_FOUND', 0x80090305, 'The requested security package does not exist.')

    # (0x80090306) The caller is not the owner of the desired credentials.
    SEC_E_NOT_OWNER = HResultCode.new('SEC_E_NOT_OWNER', 0x80090306, 'The caller is not the owner of the desired credentials.')

    # (0x80090307) The security package failed to initialize and cannot be installed.
    SEC_E_CANNOT_INSTALL = HResultCode.new('SEC_E_CANNOT_INSTALL', 0x80090307, 'The security package failed to initialize and cannot be installed.')

    # (0x80090308) The token supplied to the function is invalid.
    SEC_E_INVALID_TOKEN = HResultCode.new('SEC_E_INVALID_TOKEN', 0x80090308, 'The token supplied to the function is invalid.')

    # (0x80090309) The security package is not able to marshal the logon buffer, so the logon attempt has failed.
    SEC_E_CANNOT_PACK = HResultCode.new('SEC_E_CANNOT_PACK', 0x80090309, 'The security package is not able to marshal the logon buffer, so the logon attempt has failed.')

    # (0x8009030a) The per-message quality of protection is not supported by the security package.
    SEC_E_QOP_NOT_SUPPORTED = HResultCode.new('SEC_E_QOP_NOT_SUPPORTED', 0x8009030a, 'The per-message quality of protection is not supported by the security package.')

    # (0x8009030b) The security context does not allow impersonation of the client.
    SEC_E_NO_IMPERSONATION = HResultCode.new('SEC_E_NO_IMPERSONATION', 0x8009030b, 'The security context does not allow impersonation of the client.')

    # (0x8009030c) The logon attempt failed.
    SEC_E_LOGON_DENIED = HResultCode.new('SEC_E_LOGON_DENIED', 0x8009030c, 'The logon attempt failed.')

    # (0x8009030d) The credentials supplied to the package were not recognized.
    SEC_E_UNKNOWN_CREDENTIALS = HResultCode.new('SEC_E_UNKNOWN_CREDENTIALS', 0x8009030d, 'The credentials supplied to the package were not recognized.')

    # (0x8009030e) No credentials are available in the security package.
    SEC_E_NO_CREDENTIALS = HResultCode.new('SEC_E_NO_CREDENTIALS', 0x8009030e, 'No credentials are available in the security package.')

    # (0x8009030f) The message or signature supplied for verification has been altered.
    SEC_E_MESSAGE_ALTERED = HResultCode.new('SEC_E_MESSAGE_ALTERED', 0x8009030f, 'The message or signature supplied for verification has been altered.')

    # (0x80090310) The message supplied for verification is out of sequence.
    SEC_E_OUT_OF_SEQUENCE = HResultCode.new('SEC_E_OUT_OF_SEQUENCE', 0x80090310, 'The message supplied for verification is out of sequence.')

    # (0x80090311) No authority could be contacted for authentication.
    SEC_E_NO_AUTHENTICATING_AUTHORITY = HResultCode.new('SEC_E_NO_AUTHENTICATING_AUTHORITY', 0x80090311, 'No authority could be contacted for authentication.')

    # (0x80090316) The requested security package does not exist.
    SEC_E_BAD_PKGID = HResultCode.new('SEC_E_BAD_PKGID', 0x80090316, 'The requested security package does not exist.')

    # (0x80090317) The context has expired and can no longer be used.
    SEC_E_CONTEXT_EXPIRED = HResultCode.new('SEC_E_CONTEXT_EXPIRED', 0x80090317, 'The context has expired and can no longer be used.')

    # (0x80090318) The supplied message is incomplete. The signature was not verified.
    SEC_E_INCOMPLETE_MESSAGE = HResultCode.new('SEC_E_INCOMPLETE_MESSAGE', 0x80090318, 'The supplied message is incomplete. The signature was not verified.')

    # (0x80090320) The credentials supplied were not complete and could not be verified. The context could not be initialized.
    SEC_E_INCOMPLETE_CREDENTIALS = HResultCode.new('SEC_E_INCOMPLETE_CREDENTIALS', 0x80090320, 'The credentials supplied were not complete and could not be verified. The context could not be initialized.')

    # (0x80090321) The buffers supplied to a function was too small.
    SEC_E_BUFFER_TOO_SMALL = HResultCode.new('SEC_E_BUFFER_TOO_SMALL', 0x80090321, 'The buffers supplied to a function was too small.')

    # (0x80090322) The target principal name is incorrect.
    SEC_E_WRONG_PRINCIPAL = HResultCode.new('SEC_E_WRONG_PRINCIPAL', 0x80090322, 'The target principal name is incorrect.')

    # (0x80090324) The clocks on the client and server machines are skewed.
    SEC_E_TIME_SKEW = HResultCode.new('SEC_E_TIME_SKEW', 0x80090324, 'The clocks on the client and server machines are skewed.')

    # (0x80090325) The certificate chain was issued by an authority that is not trusted.
    SEC_E_UNTRUSTED_ROOT = HResultCode.new('SEC_E_UNTRUSTED_ROOT', 0x80090325, 'The certificate chain was issued by an authority that is not trusted.')

    # (0x80090326) The message received was unexpected or badly formatted.
    SEC_E_ILLEGAL_MESSAGE = HResultCode.new('SEC_E_ILLEGAL_MESSAGE', 0x80090326, 'The message received was unexpected or badly formatted.')

    # (0x80090327) An unknown error occurred while processing the certificate.
    SEC_E_CERT_UNKNOWN = HResultCode.new('SEC_E_CERT_UNKNOWN', 0x80090327, 'An unknown error occurred while processing the certificate.')

    # (0x80090328) The received certificate has expired.
    SEC_E_CERT_EXPIRED = HResultCode.new('SEC_E_CERT_EXPIRED', 0x80090328, 'The received certificate has expired.')

    # (0x80090329) The specified data could not be encrypted.
    SEC_E_ENCRYPT_FAILURE = HResultCode.new('SEC_E_ENCRYPT_FAILURE', 0x80090329, 'The specified data could not be encrypted.')

    # (0x80090330) The specified data could not be decrypted.
    SEC_E_DECRYPT_FAILURE = HResultCode.new('SEC_E_DECRYPT_FAILURE', 0x80090330, 'The specified data could not be decrypted.')

    # (0x80090331) The client and server cannot communicate because they do not possess a common algorithm.
    SEC_E_ALGORITHM_MISMATCH = HResultCode.new('SEC_E_ALGORITHM_MISMATCH', 0x80090331, 'The client and server cannot communicate because they do not possess a common algorithm.')

    # (0x80090332) The security context could not be established due to a failure in the requested quality of service (for example, mutual authentication or delegation).
    SEC_E_SECURITY_QOS_FAILED = HResultCode.new('SEC_E_SECURITY_QOS_FAILED', 0x80090332, 'The security context could not be established due to a failure in the requested quality of service (for example, mutual authentication or delegation).')

    # (0x80090333) A security context was deleted before the context was completed. This is considered a logon failure.
    SEC_E_UNFINISHED_CONTEXT_DELETED = HResultCode.new('SEC_E_UNFINISHED_CONTEXT_DELETED', 0x80090333, 'A security context was deleted before the context was completed. This is considered a logon failure.')

    # (0x80090334) The client is trying to negotiate a context and the server requires user-to-user but did not send a ticket granting ticket (TGT) reply.
    SEC_E_NO_TGT_REPLY = HResultCode.new('SEC_E_NO_TGT_REPLY', 0x80090334, 'The client is trying to negotiate a context and the server requires user-to-user but did not send a ticket granting ticket (TGT) reply.')

    # (0x80090335) Unable to accomplish the requested task because the local machine does not have an IP addresses.
    SEC_E_NO_IP_ADDRESSES = HResultCode.new('SEC_E_NO_IP_ADDRESSES', 0x80090335, 'Unable to accomplish the requested task because the local machine does not have an IP addresses.')

    # (0x80090336) The supplied credential handle does not match the credential associated with the security context.
    SEC_E_WRONG_CREDENTIAL_HANDLE = HResultCode.new('SEC_E_WRONG_CREDENTIAL_HANDLE', 0x80090336, 'The supplied credential handle does not match the credential associated with the security context.')

    # (0x80090337) The cryptographic system or checksum function is invalid because a required function is unavailable.
    SEC_E_CRYPTO_SYSTEM_INVALID = HResultCode.new('SEC_E_CRYPTO_SYSTEM_INVALID', 0x80090337, 'The cryptographic system or checksum function is invalid because a required function is unavailable.')

    # (0x80090338) The number of maximum ticket referrals has been exceeded.
    SEC_E_MAX_REFERRALS_EXCEEDED = HResultCode.new('SEC_E_MAX_REFERRALS_EXCEEDED', 0x80090338, 'The number of maximum ticket referrals has been exceeded.')

    # (0x80090339) The local machine must be a Kerberos domain controller (KDC), and it is not.
    SEC_E_MUST_BE_KDC = HResultCode.new('SEC_E_MUST_BE_KDC', 0x80090339, 'The local machine must be a Kerberos domain controller (KDC), and it is not.')

    # (0x8009033a) The other end of the security negotiation requires strong cryptographics, but it is not supported on the local machine.
    SEC_E_STRONG_CRYPTO_NOT_SUPPORTED = HResultCode.new('SEC_E_STRONG_CRYPTO_NOT_SUPPORTED', 0x8009033a, 'The other end of the security negotiation requires strong cryptographics, but it is not supported on the local machine.')

    # (0x8009033b) The KDC reply contained more than one principal name.
    SEC_E_TOO_MANY_PRINCIPALS = HResultCode.new('SEC_E_TOO_MANY_PRINCIPALS', 0x8009033b, 'The KDC reply contained more than one principal name.')

    # (0x8009033c) Expected to find PA data for a hint of what etype to use, but it was not found.
    SEC_E_NO_PA_DATA = HResultCode.new('SEC_E_NO_PA_DATA', 0x8009033c, 'Expected to find PA data for a hint of what etype to use, but it was not found.')

    # (0x8009033d) The client certificate does not contain a valid user principal name (UPN), or does not match the client name in the logon request. Contact your administrator.
    SEC_E_PKINIT_NAME_MISMATCH = HResultCode.new('SEC_E_PKINIT_NAME_MISMATCH', 0x8009033d, 'The client certificate does not contain a valid user principal name (UPN), or does not match the client name in the logon request. Contact your administrator.')

    # (0x8009033e) Smart card logon is required and was not used.
    SEC_E_SMARTCARD_LOGON_REQUIRED = HResultCode.new('SEC_E_SMARTCARD_LOGON_REQUIRED', 0x8009033e, 'Smart card logon is required and was not used.')

    # (0x8009033f) A system shutdown is in progress.
    SEC_E_SHUTDOWN_IN_PROGRESS = HResultCode.new('SEC_E_SHUTDOWN_IN_PROGRESS', 0x8009033f, 'A system shutdown is in progress.')

    # (0x80090340) An invalid request was sent to the KDC.
    SEC_E_KDC_INVALID_REQUEST = HResultCode.new('SEC_E_KDC_INVALID_REQUEST', 0x80090340, 'An invalid request was sent to the KDC.')

    # (0x80090341) The KDC was unable to generate a referral for the service requested.
    SEC_E_KDC_UNABLE_TO_REFER = HResultCode.new('SEC_E_KDC_UNABLE_TO_REFER', 0x80090341, 'The KDC was unable to generate a referral for the service requested.')

    # (0x80090342) The encryption type requested is not supported by the KDC.
    SEC_E_KDC_UNKNOWN_ETYPE = HResultCode.new('SEC_E_KDC_UNKNOWN_ETYPE', 0x80090342, 'The encryption type requested is not supported by the KDC.')

    # (0x80090343) An unsupported pre-authentication mechanism was presented to the Kerberos package.
    SEC_E_UNSUPPORTED_PREAUTH = HResultCode.new('SEC_E_UNSUPPORTED_PREAUTH', 0x80090343, 'An unsupported pre-authentication mechanism was presented to the Kerberos package.')

    # (0x80090345) The requested operation cannot be completed. The computer must be trusted for delegation, and the current user account must be configured to allow delegation.
    SEC_E_DELEGATION_REQUIRED = HResultCode.new('SEC_E_DELEGATION_REQUIRED', 0x80090345, 'The requested operation cannot be completed. The computer must be trusted for delegation, and the current user account must be configured to allow delegation.')

    # (0x80090346) Client's supplied Security Support Provider Interface (SSPI) channel bindings were incorrect.
    SEC_E_BAD_BINDINGS = HResultCode.new('SEC_E_BAD_BINDINGS', 0x80090346, 'Client\'s supplied Security Support Provider Interface (SSPI) channel bindings were incorrect.')

    # (0x80090347) The received certificate was mapped to multiple accounts.
    SEC_E_MULTIPLE_ACCOUNTS = HResultCode.new('SEC_E_MULTIPLE_ACCOUNTS', 0x80090347, 'The received certificate was mapped to multiple accounts.')

    # (0x80090348) No Kerberos key was found.
    SEC_E_NO_KERB_KEY = HResultCode.new('SEC_E_NO_KERB_KEY', 0x80090348, 'No Kerberos key was found.')

    # (0x80090349) The certificate is not valid for the requested usage.
    SEC_E_CERT_WRONG_USAGE = HResultCode.new('SEC_E_CERT_WRONG_USAGE', 0x80090349, 'The certificate is not valid for the requested usage.')

    # (0x80090350) The system detected a possible attempt to compromise security. Ensure that you can contact the server that authenticated you.
    SEC_E_DOWNGRADE_DETECTED = HResultCode.new('SEC_E_DOWNGRADE_DETECTED', 0x80090350, 'The system detected a possible attempt to compromise security. Ensure that you can contact the server that authenticated you.')

    # (0x80090351) The smart card certificate used for authentication has been revoked. Contact your system administrator. The event log might contain additional information.
    SEC_E_SMARTCARD_CERT_REVOKED = HResultCode.new('SEC_E_SMARTCARD_CERT_REVOKED', 0x80090351, 'The smart card certificate used for authentication has been revoked. Contact your system administrator. The event log might contain additional information.')

    # (0x80090352) An untrusted certification authority (CA) was detected while processing the smart card certificate used for authentication. Contact your system administrator.
    SEC_E_ISSUING_CA_UNTRUSTED = HResultCode.new('SEC_E_ISSUING_CA_UNTRUSTED', 0x80090352, 'An untrusted certification authority (CA) was detected while processing the smart card certificate used for authentication. Contact your system administrator.')

    # (0x80090353) The revocation status of the smart card certificate used for authentication could not be determined. Contact your system administrator.
    SEC_E_REVOCATION_OFFLINE_C = HResultCode.new('SEC_E_REVOCATION_OFFLINE_C', 0x80090353, 'The revocation status of the smart card certificate used for authentication could not be determined. Contact your system administrator.')

    # (0x80090354) The smart card certificate used for authentication was not trusted. Contact your system administrator.
    SEC_E_PKINIT_CLIENT_FAILURE = HResultCode.new('SEC_E_PKINIT_CLIENT_FAILURE', 0x80090354, 'The smart card certificate used for authentication was not trusted. Contact your system administrator.')

    # (0x80090355) The smart card certificate used for authentication has expired. Contact your system administrator.
    SEC_E_SMARTCARD_CERT_EXPIRED = HResultCode.new('SEC_E_SMARTCARD_CERT_EXPIRED', 0x80090355, 'The smart card certificate used for authentication has expired. Contact your system administrator.')

    # (0x80090356) The Kerberos subsystem encountered an error. A service for user protocol requests was made against a domain controller that does not support services for users.
    SEC_E_NO_S4U_PROT_SUPPORT = HResultCode.new('SEC_E_NO_S4U_PROT_SUPPORT', 0x80090356, 'The Kerberos subsystem encountered an error. A service for user protocol requests was made against a domain controller that does not support services for users.')

    # (0x80090357) An attempt was made by this server to make a Kerberos-constrained delegation request for a target outside the server's realm. This is not supported and indicates a misconfiguration on this server's allowed-to-delegate-to list. Contact your administrator.
    SEC_E_CROSSREALM_DELEGATION_FAILURE = HResultCode.new('SEC_E_CROSSREALM_DELEGATION_FAILURE', 0x80090357, 'An attempt was made by this server to make a Kerberos-constrained delegation request for a target outside the server\'s realm. This is not supported and indicates a misconfiguration on this server\'s allowed-to-delegate-to list. Contact your administrator.')

    # (0x80090358) The revocation status of the domain controller certificate used for smart card authentication could not be determined. The system event log contains additional information. Contact your system administrator.
    SEC_E_REVOCATION_OFFLINE_KDC = HResultCode.new('SEC_E_REVOCATION_OFFLINE_KDC', 0x80090358, 'The revocation status of the domain controller certificate used for smart card authentication could not be determined. The system event log contains additional information. Contact your system administrator.')

    # (0x80090359) An untrusted CA was detected while processing the domain controller certificate used for authentication. The system event log contains additional information. Contact your system administrator.
    SEC_E_ISSUING_CA_UNTRUSTED_KDC = HResultCode.new('SEC_E_ISSUING_CA_UNTRUSTED_KDC', 0x80090359, 'An untrusted CA was detected while processing the domain controller certificate used for authentication. The system event log contains additional information. Contact your system administrator.')

    # (0x8009035a) The domain controller certificate used for smart card logon has expired. Contact your system administrator with the contents of your system event log.
    SEC_E_KDC_CERT_EXPIRED = HResultCode.new('SEC_E_KDC_CERT_EXPIRED', 0x8009035a, 'The domain controller certificate used for smart card logon has expired. Contact your system administrator with the contents of your system event log.')

    # (0x8009035b) The domain controller certificate used for smart card logon has been revoked. Contact your system administrator with the contents of your system event log.
    SEC_E_KDC_CERT_REVOKED = HResultCode.new('SEC_E_KDC_CERT_REVOKED', 0x8009035b, 'The domain controller certificate used for smart card logon has been revoked. Contact your system administrator with the contents of your system event log.')

    # (0x8009035d) One or more of the parameters passed to the function were invalid.
    SEC_E_INVALID_PARAMETER = HResultCode.new('SEC_E_INVALID_PARAMETER', 0x8009035d, 'One or more of the parameters passed to the function were invalid.')

    # (0x8009035e) The client policy does not allow credential delegation to the target server.
    SEC_E_DELEGATION_POLICY = HResultCode.new('SEC_E_DELEGATION_POLICY', 0x8009035e, 'The client policy does not allow credential delegation to the target server.')

    # (0x8009035f) The client policy does not allow credential delegation to the target server with NLTM only authentication.
    SEC_E_POLICY_NLTM_ONLY = HResultCode.new('SEC_E_POLICY_NLTM_ONLY', 0x8009035f, 'The client policy does not allow credential delegation to the target server with NLTM only authentication.')

    # (0x80091001) An error occurred while performing an operation on a cryptographic message.
    CRYPT_E_MSG_ERROR = HResultCode.new('CRYPT_E_MSG_ERROR', 0x80091001, 'An error occurred while performing an operation on a cryptographic message.')

    # (0x80091002) Unknown cryptographic algorithm.
    CRYPT_E_UNKNOWN_ALGO = HResultCode.new('CRYPT_E_UNKNOWN_ALGO', 0x80091002, 'Unknown cryptographic algorithm.')

    # (0x80091003) The object identifier is poorly formatted.
    CRYPT_E_OID_FORMAT = HResultCode.new('CRYPT_E_OID_FORMAT', 0x80091003, 'The object identifier is poorly formatted.')

    # (0x80091004) Invalid cryptographic message type.
    CRYPT_E_INVALID_MSG_TYPE = HResultCode.new('CRYPT_E_INVALID_MSG_TYPE', 0x80091004, 'Invalid cryptographic message type.')

    # (0x80091005) Unexpected cryptographic message encoding.
    CRYPT_E_UNEXPECTED_ENCODING = HResultCode.new('CRYPT_E_UNEXPECTED_ENCODING', 0x80091005, 'Unexpected cryptographic message encoding.')

    # (0x80091006) The cryptographic message does not contain an expected authenticated attribute.
    CRYPT_E_AUTH_ATTR_MISSING = HResultCode.new('CRYPT_E_AUTH_ATTR_MISSING', 0x80091006, 'The cryptographic message does not contain an expected authenticated attribute.')

    # (0x80091007) The hash value is not correct.
    CRYPT_E_HASH_VALUE = HResultCode.new('CRYPT_E_HASH_VALUE', 0x80091007, 'The hash value is not correct.')

    # (0x80091008) The index value is not valid.
    CRYPT_E_INVALID_INDEX = HResultCode.new('CRYPT_E_INVALID_INDEX', 0x80091008, 'The index value is not valid.')

    # (0x80091009) The content of the cryptographic message has already been decrypted.
    CRYPT_E_ALREADY_DECRYPTED = HResultCode.new('CRYPT_E_ALREADY_DECRYPTED', 0x80091009, 'The content of the cryptographic message has already been decrypted.')

    # (0x8009100a) The content of the cryptographic message has not been decrypted yet.
    CRYPT_E_NOT_DECRYPTED = HResultCode.new('CRYPT_E_NOT_DECRYPTED', 0x8009100a, 'The content of the cryptographic message has not been decrypted yet.')

    # (0x8009100b) The enveloped-data message does not contain the specified recipient.
    CRYPT_E_RECIPIENT_NOT_FOUND = HResultCode.new('CRYPT_E_RECIPIENT_NOT_FOUND', 0x8009100b, 'The enveloped-data message does not contain the specified recipient.')

    # (0x8009100c) Invalid control type.
    CRYPT_E_CONTROL_TYPE = HResultCode.new('CRYPT_E_CONTROL_TYPE', 0x8009100c, 'Invalid control type.')

    # (0x8009100d) Invalid issuer or serial number.
    CRYPT_E_ISSUER_SERIALNUMBER = HResultCode.new('CRYPT_E_ISSUER_SERIALNUMBER', 0x8009100d, 'Invalid issuer or serial number.')

    # (0x8009100e) Cannot find the original signer.
    CRYPT_E_SIGNER_NOT_FOUND = HResultCode.new('CRYPT_E_SIGNER_NOT_FOUND', 0x8009100e, 'Cannot find the original signer.')

    # (0x8009100f) The cryptographic message does not contain all of the requested attributes.
    CRYPT_E_ATTRIBUTES_MISSING = HResultCode.new('CRYPT_E_ATTRIBUTES_MISSING', 0x8009100f, 'The cryptographic message does not contain all of the requested attributes.')

    # (0x80091010) The streamed cryptographic message is not ready to return data.
    CRYPT_E_STREAM_MSG_NOT_READY = HResultCode.new('CRYPT_E_STREAM_MSG_NOT_READY', 0x80091010, 'The streamed cryptographic message is not ready to return data.')

    # (0x80091011) The streamed cryptographic message requires more data to complete the decode operation.
    CRYPT_E_STREAM_INSUFFICIENT_DATA = HResultCode.new('CRYPT_E_STREAM_INSUFFICIENT_DATA', 0x80091011, 'The streamed cryptographic message requires more data to complete the decode operation.')

    # (0x80092001) The length specified for the output data was insufficient.
    CRYPT_E_BAD_LEN = HResultCode.new('CRYPT_E_BAD_LEN', 0x80092001, 'The length specified for the output data was insufficient.')

    # (0x80092002) An error occurred during the encode or decode operation.
    CRYPT_E_BAD_ENCODE = HResultCode.new('CRYPT_E_BAD_ENCODE', 0x80092002, 'An error occurred during the encode or decode operation.')

    # (0x80092003) An error occurred while reading or writing to a file.
    CRYPT_E_FILE_ERROR = HResultCode.new('CRYPT_E_FILE_ERROR', 0x80092003, 'An error occurred while reading or writing to a file.')

    # (0x80092004) Cannot find object or property.
    CRYPT_E_NOT_FOUND = HResultCode.new('CRYPT_E_NOT_FOUND', 0x80092004, 'Cannot find object or property.')

    # (0x80092005) The object or property already exists.
    CRYPT_E_EXISTS = HResultCode.new('CRYPT_E_EXISTS', 0x80092005, 'The object or property already exists.')

    # (0x80092006) No provider was specified for the store or object.
    CRYPT_E_NO_PROVIDER = HResultCode.new('CRYPT_E_NO_PROVIDER', 0x80092006, 'No provider was specified for the store or object.')

    # (0x80092007) The specified certificate is self-signed.
    CRYPT_E_SELF_SIGNED = HResultCode.new('CRYPT_E_SELF_SIGNED', 0x80092007, 'The specified certificate is self-signed.')

    # (0x80092008) The previous certificate or certificate revocation list (CRL) context was deleted.
    CRYPT_E_DELETED_PREV = HResultCode.new('CRYPT_E_DELETED_PREV', 0x80092008, 'The previous certificate or certificate revocation list (CRL) context was deleted.')

    # (0x80092009) Cannot find the requested object.
    CRYPT_E_NO_MATCH = HResultCode.new('CRYPT_E_NO_MATCH', 0x80092009, 'Cannot find the requested object.')

    # (0x8009200a) The certificate does not have a property that references a private key.
    CRYPT_E_UNEXPECTED_MSG_TYPE = HResultCode.new('CRYPT_E_UNEXPECTED_MSG_TYPE', 0x8009200a, 'The certificate does not have a property that references a private key.')

    # (0x8009200b) Cannot find the certificate and private key for decryption.
    CRYPT_E_NO_KEY_PROPERTY = HResultCode.new('CRYPT_E_NO_KEY_PROPERTY', 0x8009200b, 'Cannot find the certificate and private key for decryption.')

    # (0x8009200c) Cannot find the certificate and private key to use for decryption.
    CRYPT_E_NO_DECRYPT_CERT = HResultCode.new('CRYPT_E_NO_DECRYPT_CERT', 0x8009200c, 'Cannot find the certificate and private key to use for decryption.')

    # (0x8009200d) Not a cryptographic message or the cryptographic message is not formatted correctly.
    CRYPT_E_BAD_MSG = HResultCode.new('CRYPT_E_BAD_MSG', 0x8009200d, 'Not a cryptographic message or the cryptographic message is not formatted correctly.')

    # (0x8009200e) The signed cryptographic message does not have a signer for the specified signer index.
    CRYPT_E_NO_SIGNER = HResultCode.new('CRYPT_E_NO_SIGNER', 0x8009200e, 'The signed cryptographic message does not have a signer for the specified signer index.')

    # (0x8009200f) Final closure is pending until additional frees or closes.
    CRYPT_E_PENDING_CLOSE = HResultCode.new('CRYPT_E_PENDING_CLOSE', 0x8009200f, 'Final closure is pending until additional frees or closes.')

    # (0x80092010) The certificate is revoked.
    CRYPT_E_REVOKED = HResultCode.new('CRYPT_E_REVOKED', 0x80092010, 'The certificate is revoked.')

    # (0x80092011) No DLL or exported function was found to verify revocation.
    CRYPT_E_NO_REVOCATION_DLL = HResultCode.new('CRYPT_E_NO_REVOCATION_DLL', 0x80092011, 'No DLL or exported function was found to verify revocation.')

    # (0x80092012) The revocation function was unable to check revocation for the certificate.
    CRYPT_E_NO_REVOCATION_CHECK = HResultCode.new('CRYPT_E_NO_REVOCATION_CHECK', 0x80092012, 'The revocation function was unable to check revocation for the certificate.')

    # (0x80092013) The revocation function was unable to check revocation because the revocation server was offline.
    CRYPT_E_REVOCATION_OFFLINE = HResultCode.new('CRYPT_E_REVOCATION_OFFLINE', 0x80092013, 'The revocation function was unable to check revocation because the revocation server was offline.')

    # (0x80092014) The certificate is not in the revocation server's database.
    CRYPT_E_NOT_IN_REVOCATION_DATABASE = HResultCode.new('CRYPT_E_NOT_IN_REVOCATION_DATABASE', 0x80092014, 'The certificate is not in the revocation server\'s database.')

    # (0x80092020) The string contains a non-numeric character.
    CRYPT_E_INVALID_NUMERIC_STRING = HResultCode.new('CRYPT_E_INVALID_NUMERIC_STRING', 0x80092020, 'The string contains a non-numeric character.')

    # (0x80092021) The string contains a nonprintable character.
    CRYPT_E_INVALID_PRINTABLE_STRING = HResultCode.new('CRYPT_E_INVALID_PRINTABLE_STRING', 0x80092021, 'The string contains a nonprintable character.')

    # (0x80092022) The string contains a character not in the 7-bit ASCII character set.
    CRYPT_E_INVALID_IA5_STRING = HResultCode.new('CRYPT_E_INVALID_IA5_STRING', 0x80092022, 'The string contains a character not in the 7-bit ASCII character set.')

    # (0x80092023) The string contains an invalid X500 name attribute key, object identifier (OID), value, or delimiter.
    CRYPT_E_INVALID_X500_STRING = HResultCode.new('CRYPT_E_INVALID_X500_STRING', 0x80092023, 'The string contains an invalid X500 name attribute key, object identifier (OID), value, or delimiter.')

    # (0x80092024) The dwValueType for the CERT_NAME_VALUE is not one of the character strings. Most likely it is either a CERT_RDN_ENCODED_BLOB or CERT_TDN_OCTED_STRING.
    CRYPT_E_NOT_CHAR_STRING = HResultCode.new('CRYPT_E_NOT_CHAR_STRING', 0x80092024, 'The dwValueType for the CERT_NAME_VALUE is not one of the character strings. Most likely it is either a CERT_RDN_ENCODED_BLOB or CERT_TDN_OCTED_STRING.')

    # (0x80092025) The Put operation cannot continue. The file needs to be resized. However, there is already a signature present. A complete signing operation must be done.
    CRYPT_E_FILERESIZED = HResultCode.new('CRYPT_E_FILERESIZED', 0x80092025, 'The Put operation cannot continue. The file needs to be resized. However, there is already a signature present. A complete signing operation must be done.')

    # (0x80092026) The cryptographic operation failed due to a local security option setting.
    CRYPT_E_SECURITY_SETTINGS = HResultCode.new('CRYPT_E_SECURITY_SETTINGS', 0x80092026, 'The cryptographic operation failed due to a local security option setting.')

    # (0x80092027) No DLL or exported function was found to verify subject usage.
    CRYPT_E_NO_VERIFY_USAGE_DLL = HResultCode.new('CRYPT_E_NO_VERIFY_USAGE_DLL', 0x80092027, 'No DLL or exported function was found to verify subject usage.')

    # (0x80092028) The called function was unable to perform a usage check on the subject.
    CRYPT_E_NO_VERIFY_USAGE_CHECK = HResultCode.new('CRYPT_E_NO_VERIFY_USAGE_CHECK', 0x80092028, 'The called function was unable to perform a usage check on the subject.')

    # (0x80092029) The called function was unable to complete the usage check because the server was offline.
    CRYPT_E_VERIFY_USAGE_OFFLINE = HResultCode.new('CRYPT_E_VERIFY_USAGE_OFFLINE', 0x80092029, 'The called function was unable to complete the usage check because the server was offline.')

    # (0x8009202a) The subject was not found in a certificate trust list (CTL).
    CRYPT_E_NOT_IN_CTL = HResultCode.new('CRYPT_E_NOT_IN_CTL', 0x8009202a, 'The subject was not found in a certificate trust list (CTL).')

    # (0x8009202b) None of the signers of the cryptographic message or certificate trust list is trusted.
    CRYPT_E_NO_TRUSTED_SIGNER = HResultCode.new('CRYPT_E_NO_TRUSTED_SIGNER', 0x8009202b, 'None of the signers of the cryptographic message or certificate trust list is trusted.')

    # (0x8009202c) The public key's algorithm parameters are missing.
    CRYPT_E_MISSING_PUBKEY_PARA = HResultCode.new('CRYPT_E_MISSING_PUBKEY_PARA', 0x8009202c, 'The public key\'s algorithm parameters are missing.')

    # (0x80093000) OSS Certificate encode/decode error code base.
    CRYPT_E_OSS_ERROR = HResultCode.new('CRYPT_E_OSS_ERROR', 0x80093000, 'OSS Certificate encode/decode error code base.')

    # (0x80093001) OSS ASN.1 Error: Output Buffer is too small.
    OSS_MORE_BUF = HResultCode.new('OSS_MORE_BUF', 0x80093001, 'OSS ASN.1 Error: Output Buffer is too small.')

    # (0x80093002) OSS ASN.1 Error: Signed integer is encoded as a unsigned integer.
    OSS_NEGATIVE_UINTEGER = HResultCode.new('OSS_NEGATIVE_UINTEGER', 0x80093002, 'OSS ASN.1 Error: Signed integer is encoded as a unsigned integer.')

    # (0x80093003) OSS ASN.1 Error: Unknown ASN.1 data type.
    OSS_PDU_RANGE = HResultCode.new('OSS_PDU_RANGE', 0x80093003, 'OSS ASN.1 Error: Unknown ASN.1 data type.')

    # (0x80093004) OSS ASN.1 Error: Output buffer is too small; the decoded data has been truncated.
    OSS_MORE_INPUT = HResultCode.new('OSS_MORE_INPUT', 0x80093004, 'OSS ASN.1 Error: Output buffer is too small; the decoded data has been truncated.')

    # (0x80093005) OSS ASN.1 Error: Invalid data.
    OSS_DATA_ERROR = HResultCode.new('OSS_DATA_ERROR', 0x80093005, 'OSS ASN.1 Error: Invalid data.')

    # (0x80093006) OSS ASN.1 Error: Invalid argument.
    OSS_BAD_ARG = HResultCode.new('OSS_BAD_ARG', 0x80093006, 'OSS ASN.1 Error: Invalid argument.')

    # (0x80093007) OSS ASN.1 Error: Encode/Decode version mismatch.
    OSS_BAD_VERSION = HResultCode.new('OSS_BAD_VERSION', 0x80093007, 'OSS ASN.1 Error: Encode/Decode version mismatch.')

    # (0x80093008) OSS ASN.1 Error: Out of memory.
    OSS_OUT_MEMORY = HResultCode.new('OSS_OUT_MEMORY', 0x80093008, 'OSS ASN.1 Error: Out of memory.')

    # (0x80093009) OSS ASN.1 Error: Encode/Decode error.
    OSS_PDU_MISMATCH = HResultCode.new('OSS_PDU_MISMATCH', 0x80093009, 'OSS ASN.1 Error: Encode/Decode error.')

    # (0x8009300a) OSS ASN.1 Error: Internal error.
    OSS_LIMITED = HResultCode.new('OSS_LIMITED', 0x8009300a, 'OSS ASN.1 Error: Internal error.')

    # (0x8009300b) OSS ASN.1 Error: Invalid data.
    OSS_BAD_PTR = HResultCode.new('OSS_BAD_PTR', 0x8009300b, 'OSS ASN.1 Error: Invalid data.')

    # (0x8009300c) OSS ASN.1 Error: Invalid data.
    OSS_BAD_TIME = HResultCode.new('OSS_BAD_TIME', 0x8009300c, 'OSS ASN.1 Error: Invalid data.')

    # (0x8009300d) OSS ASN.1 Error: Unsupported BER indefinite-length encoding.
    OSS_INDEFINITE_NOT_SUPPORTED = HResultCode.new('OSS_INDEFINITE_NOT_SUPPORTED', 0x8009300d, 'OSS ASN.1 Error: Unsupported BER indefinite-length encoding.')

    # (0x8009300e) OSS ASN.1 Error: Access violation.
    OSS_MEM_ERROR = HResultCode.new('OSS_MEM_ERROR', 0x8009300e, 'OSS ASN.1 Error: Access violation.')

    # (0x8009300f) OSS ASN.1 Error: Invalid data.
    OSS_BAD_TABLE = HResultCode.new('OSS_BAD_TABLE', 0x8009300f, 'OSS ASN.1 Error: Invalid data.')

    # (0x80093010) OSS ASN.1 Error: Invalid data.
    OSS_TOO_LONG = HResultCode.new('OSS_TOO_LONG', 0x80093010, 'OSS ASN.1 Error: Invalid data.')

    # (0x80093011) OSS ASN.1 Error: Invalid data.
    OSS_CONSTRAINT_VIOLATED = HResultCode.new('OSS_CONSTRAINT_VIOLATED', 0x80093011, 'OSS ASN.1 Error: Invalid data.')

    # (0x80093012) OSS ASN.1 Error: Internal error.
    OSS_FATAL_ERROR = HResultCode.new('OSS_FATAL_ERROR', 0x80093012, 'OSS ASN.1 Error: Internal error.')

    # (0x80093013) OSS ASN.1 Error: Multithreading conflict.
    OSS_ACCESS_SERIALIZATION_ERROR = HResultCode.new('OSS_ACCESS_SERIALIZATION_ERROR', 0x80093013, 'OSS ASN.1 Error: Multithreading conflict.')

    # (0x80093014) OSS ASN.1 Error: Invalid data.
    OSS_NULL_TBL = HResultCode.new('OSS_NULL_TBL', 0x80093014, 'OSS ASN.1 Error: Invalid data.')

    # (0x80093015) OSS ASN.1 Error: Invalid data.
    OSS_NULL_FCN = HResultCode.new('OSS_NULL_FCN', 0x80093015, 'OSS ASN.1 Error: Invalid data.')

    # (0x80093016) OSS ASN.1 Error: Invalid data.
    OSS_BAD_ENCRULES = HResultCode.new('OSS_BAD_ENCRULES', 0x80093016, 'OSS ASN.1 Error: Invalid data.')

    # (0x80093017) OSS ASN.1 Error: Encode/Decode function not implemented.
    OSS_UNAVAIL_ENCRULES = HResultCode.new('OSS_UNAVAIL_ENCRULES', 0x80093017, 'OSS ASN.1 Error: Encode/Decode function not implemented.')

    # (0x80093018) OSS ASN.1 Error: Trace file error.
    OSS_CANT_OPEN_TRACE_WINDOW = HResultCode.new('OSS_CANT_OPEN_TRACE_WINDOW', 0x80093018, 'OSS ASN.1 Error: Trace file error.')

    # (0x80093019) OSS ASN.1 Error: Function not implemented.
    OSS_UNIMPLEMENTED = HResultCode.new('OSS_UNIMPLEMENTED', 0x80093019, 'OSS ASN.1 Error: Function not implemented.')

    # (0x8009301a) OSS ASN.1 Error: Program link error.
    OSS_OID_DLL_NOT_LINKED = HResultCode.new('OSS_OID_DLL_NOT_LINKED', 0x8009301a, 'OSS ASN.1 Error: Program link error.')

    # (0x8009301b) OSS ASN.1 Error: Trace file error.
    OSS_CANT_OPEN_TRACE_FILE = HResultCode.new('OSS_CANT_OPEN_TRACE_FILE', 0x8009301b, 'OSS ASN.1 Error: Trace file error.')

    # (0x8009301c) OSS ASN.1 Error: Trace file error.
    OSS_TRACE_FILE_ALREADY_OPEN = HResultCode.new('OSS_TRACE_FILE_ALREADY_OPEN', 0x8009301c, 'OSS ASN.1 Error: Trace file error.')

    # (0x8009301d) OSS ASN.1 Error: Invalid data.
    OSS_TABLE_MISMATCH = HResultCode.new('OSS_TABLE_MISMATCH', 0x8009301d, 'OSS ASN.1 Error: Invalid data.')

    # (0x8009301e) OSS ASN.1 Error: Invalid data.
    OSS_TYPE_NOT_SUPPORTED = HResultCode.new('OSS_TYPE_NOT_SUPPORTED', 0x8009301e, 'OSS ASN.1 Error: Invalid data.')

    # (0x8009301f) OSS ASN.1 Error: Program link error.
    OSS_REAL_DLL_NOT_LINKED = HResultCode.new('OSS_REAL_DLL_NOT_LINKED', 0x8009301f, 'OSS ASN.1 Error: Program link error.')

    # (0x80093020) OSS ASN.1 Error: Program link error.
    OSS_REAL_CODE_NOT_LINKED = HResultCode.new('OSS_REAL_CODE_NOT_LINKED', 0x80093020, 'OSS ASN.1 Error: Program link error.')

    # (0x80093021) OSS ASN.1 Error: Program link error.
    OSS_OUT_OF_RANGE = HResultCode.new('OSS_OUT_OF_RANGE', 0x80093021, 'OSS ASN.1 Error: Program link error.')

    # (0x80093022) OSS ASN.1 Error: Program link error.
    OSS_COPIER_DLL_NOT_LINKED = HResultCode.new('OSS_COPIER_DLL_NOT_LINKED', 0x80093022, 'OSS ASN.1 Error: Program link error.')

    # (0x80093023) OSS ASN.1 Error: Program link error.
    OSS_CONSTRAINT_DLL_NOT_LINKED = HResultCode.new('OSS_CONSTRAINT_DLL_NOT_LINKED', 0x80093023, 'OSS ASN.1 Error: Program link error.')

    # (0x80093024) OSS ASN.1 Error: Program link error.
    OSS_COMPARATOR_DLL_NOT_LINKED = HResultCode.new('OSS_COMPARATOR_DLL_NOT_LINKED', 0x80093024, 'OSS ASN.1 Error: Program link error.')

    # (0x80093025) OSS ASN.1 Error: Program link error.
    OSS_COMPARATOR_CODE_NOT_LINKED = HResultCode.new('OSS_COMPARATOR_CODE_NOT_LINKED', 0x80093025, 'OSS ASN.1 Error: Program link error.')

    # (0x80093026) OSS ASN.1 Error: Program link error.
    OSS_MEM_MGR_DLL_NOT_LINKED = HResultCode.new('OSS_MEM_MGR_DLL_NOT_LINKED', 0x80093026, 'OSS ASN.1 Error: Program link error.')

    # (0x80093027) OSS ASN.1 Error: Program link error.
    OSS_PDV_DLL_NOT_LINKED = HResultCode.new('OSS_PDV_DLL_NOT_LINKED', 0x80093027, 'OSS ASN.1 Error: Program link error.')

    # (0x80093028) OSS ASN.1 Error: Program link error.
    OSS_PDV_CODE_NOT_LINKED = HResultCode.new('OSS_PDV_CODE_NOT_LINKED', 0x80093028, 'OSS ASN.1 Error: Program link error.')

    # (0x80093029) OSS ASN.1 Error: Program link error.
    OSS_API_DLL_NOT_LINKED = HResultCode.new('OSS_API_DLL_NOT_LINKED', 0x80093029, 'OSS ASN.1 Error: Program link error.')

    # (0x8009302a) OSS ASN.1 Error: Program link error.
    OSS_BERDER_DLL_NOT_LINKED = HResultCode.new('OSS_BERDER_DLL_NOT_LINKED', 0x8009302a, 'OSS ASN.1 Error: Program link error.')

    # (0x8009302b) OSS ASN.1 Error: Program link error.
    OSS_PER_DLL_NOT_LINKED = HResultCode.new('OSS_PER_DLL_NOT_LINKED', 0x8009302b, 'OSS ASN.1 Error: Program link error.')

    # (0x8009302c) OSS ASN.1 Error: Program link error.
    OSS_OPEN_TYPE_ERROR = HResultCode.new('OSS_OPEN_TYPE_ERROR', 0x8009302c, 'OSS ASN.1 Error: Program link error.')

    # (0x8009302d) OSS ASN.1 Error: System resource error.
    OSS_MUTEX_NOT_CREATED = HResultCode.new('OSS_MUTEX_NOT_CREATED', 0x8009302d, 'OSS ASN.1 Error: System resource error.')

    # (0x8009302e) OSS ASN.1 Error: Trace file error.
    OSS_CANT_CLOSE_TRACE_FILE = HResultCode.new('OSS_CANT_CLOSE_TRACE_FILE', 0x8009302e, 'OSS ASN.1 Error: Trace file error.')

    # (0x80093100) ASN1 Certificate encode/decode error code base.
    CRYPT_E_ASN1_ERROR = HResultCode.new('CRYPT_E_ASN1_ERROR', 0x80093100, 'ASN1 Certificate encode/decode error code base.')

    # (0x80093101) ASN1 internal encode or decode error.
    CRYPT_E_ASN1_INTERNAL = HResultCode.new('CRYPT_E_ASN1_INTERNAL', 0x80093101, 'ASN1 internal encode or decode error.')

    # (0x80093102) ASN1 unexpected end of data.
    CRYPT_E_ASN1_EOD = HResultCode.new('CRYPT_E_ASN1_EOD', 0x80093102, 'ASN1 unexpected end of data.')

    # (0x80093103) ASN1 corrupted data.
    CRYPT_E_ASN1_CORRUPT = HResultCode.new('CRYPT_E_ASN1_CORRUPT', 0x80093103, 'ASN1 corrupted data.')

    # (0x80093104) ASN1 value too large.
    CRYPT_E_ASN1_LARGE = HResultCode.new('CRYPT_E_ASN1_LARGE', 0x80093104, 'ASN1 value too large.')

    # (0x80093105) ASN1 constraint violated.
    CRYPT_E_ASN1_CONSTRAINT = HResultCode.new('CRYPT_E_ASN1_CONSTRAINT', 0x80093105, 'ASN1 constraint violated.')

    # (0x80093106) ASN1 out of memory.
    CRYPT_E_ASN1_MEMORY = HResultCode.new('CRYPT_E_ASN1_MEMORY', 0x80093106, 'ASN1 out of memory.')

    # (0x80093107) ASN1 buffer overflow.
    CRYPT_E_ASN1_OVERFLOW = HResultCode.new('CRYPT_E_ASN1_OVERFLOW', 0x80093107, 'ASN1 buffer overflow.')

    # (0x80093108) ASN1 function not supported for this protocol data unit (PDU).
    CRYPT_E_ASN1_BADPDU = HResultCode.new('CRYPT_E_ASN1_BADPDU', 0x80093108, 'ASN1 function not supported for this protocol data unit (PDU).')

    # (0x80093109) ASN1 bad arguments to function call.
    CRYPT_E_ASN1_BADARGS = HResultCode.new('CRYPT_E_ASN1_BADARGS', 0x80093109, 'ASN1 bad arguments to function call.')

    # (0x8009310a) ASN1 bad real value.
    CRYPT_E_ASN1_BADREAL = HResultCode.new('CRYPT_E_ASN1_BADREAL', 0x8009310a, 'ASN1 bad real value.')

    # (0x8009310b) ASN1 bad tag value met.
    CRYPT_E_ASN1_BADTAG = HResultCode.new('CRYPT_E_ASN1_BADTAG', 0x8009310b, 'ASN1 bad tag value met.')

    # (0x8009310c) ASN1 bad choice value.
    CRYPT_E_ASN1_CHOICE = HResultCode.new('CRYPT_E_ASN1_CHOICE', 0x8009310c, 'ASN1 bad choice value.')

    # (0x8009310d) ASN1 bad encoding rule.
    CRYPT_E_ASN1_RULE = HResultCode.new('CRYPT_E_ASN1_RULE', 0x8009310d, 'ASN1 bad encoding rule.')

    # (0x8009310e) ASN1 bad Unicode (UTF8).
    CRYPT_E_ASN1_UTF8 = HResultCode.new('CRYPT_E_ASN1_UTF8', 0x8009310e, 'ASN1 bad Unicode (UTF8).')

    # (0x80093133) ASN1 bad PDU type.
    CRYPT_E_ASN1_PDU_TYPE = HResultCode.new('CRYPT_E_ASN1_PDU_TYPE', 0x80093133, 'ASN1 bad PDU type.')

    # (0x80093134) ASN1 not yet implemented.
    CRYPT_E_ASN1_NYI = HResultCode.new('CRYPT_E_ASN1_NYI', 0x80093134, 'ASN1 not yet implemented.')

    # (0x80093201) ASN1 skipped unknown extensions.
    CRYPT_E_ASN1_EXTENDED = HResultCode.new('CRYPT_E_ASN1_EXTENDED', 0x80093201, 'ASN1 skipped unknown extensions.')

    # (0x80093202) ASN1 end of data expected.
    CRYPT_E_ASN1_NOEOD = HResultCode.new('CRYPT_E_ASN1_NOEOD', 0x80093202, 'ASN1 end of data expected.')

    # (0x80094001) The request subject name is invalid or too long.
    CERTSRV_E_BAD_REQUESTSUBJECT = HResultCode.new('CERTSRV_E_BAD_REQUESTSUBJECT', 0x80094001, 'The request subject name is invalid or too long.')

    # (0x80094002) The request does not exist.
    CERTSRV_E_NO_REQUEST = HResultCode.new('CERTSRV_E_NO_REQUEST', 0x80094002, 'The request does not exist.')

    # (0x80094003) The request's current status does not allow this operation.
    CERTSRV_E_BAD_REQUESTSTATUS = HResultCode.new('CERTSRV_E_BAD_REQUESTSTATUS', 0x80094003, 'The request\'s current status does not allow this operation.')

    # (0x80094004) The requested property value is empty.
    CERTSRV_E_PROPERTY_EMPTY = HResultCode.new('CERTSRV_E_PROPERTY_EMPTY', 0x80094004, 'The requested property value is empty.')

    # (0x80094005) The CA's certificate contains invalid data.
    CERTSRV_E_INVALID_CA_CERTIFICATE = HResultCode.new('CERTSRV_E_INVALID_CA_CERTIFICATE', 0x80094005, 'The CA\'s certificate contains invalid data.')

    # (0x80094006) Certificate service has been suspended for a database restore operation.
    CERTSRV_E_SERVER_SUSPENDED = HResultCode.new('CERTSRV_E_SERVER_SUSPENDED', 0x80094006, 'Certificate service has been suspended for a database restore operation.')

    # (0x80094007) The certificate contains an encoded length that is potentially incompatible with older enrollment software.
    CERTSRV_E_ENCODING_LENGTH = HResultCode.new('CERTSRV_E_ENCODING_LENGTH', 0x80094007, 'The certificate contains an encoded length that is potentially incompatible with older enrollment software.')

    # (0x80094008) The operation is denied. The user has multiple roles assigned, and the CA is configured to enforce role separation.
    CERTSRV_E_ROLECONFLICT = HResultCode.new('CERTSRV_E_ROLECONFLICT', 0x80094008, 'The operation is denied. The user has multiple roles assigned, and the CA is configured to enforce role separation.')

    # (0x80094009) The operation is denied. It can only be performed by a certificate manager that is allowed to manage certificates for the current requester.
    CERTSRV_E_RESTRICTEDOFFICER = HResultCode.new('CERTSRV_E_RESTRICTEDOFFICER', 0x80094009, 'The operation is denied. It can only be performed by a certificate manager that is allowed to manage certificates for the current requester.')

    # (0x8009400a) Cannot archive private key. The CA is not configured for key archival.
    CERTSRV_E_KEY_ARCHIVAL_NOT_CONFIGURED = HResultCode.new('CERTSRV_E_KEY_ARCHIVAL_NOT_CONFIGURED', 0x8009400a, 'Cannot archive private key. The CA is not configured for key archival.')

    # (0x8009400b) Cannot archive private key. The CA could not verify one or more key recovery certificates.
    CERTSRV_E_NO_VALID_KRA = HResultCode.new('CERTSRV_E_NO_VALID_KRA', 0x8009400b, 'Cannot archive private key. The CA could not verify one or more key recovery certificates.')

    # (0x8009400c) The request is incorrectly formatted. The encrypted private key must be in an unauthenticated attribute in an outermost signature.
    CERTSRV_E_BAD_REQUEST_KEY_ARCHIVAL = HResultCode.new('CERTSRV_E_BAD_REQUEST_KEY_ARCHIVAL', 0x8009400c, 'The request is incorrectly formatted. The encrypted private key must be in an unauthenticated attribute in an outermost signature.')

    # (0x8009400d) At least one security principal must have the permission to manage this CA.
    CERTSRV_E_NO_CAADMIN_DEFINED = HResultCode.new('CERTSRV_E_NO_CAADMIN_DEFINED', 0x8009400d, 'At least one security principal must have the permission to manage this CA.')

    # (0x8009400e) The request contains an invalid renewal certificate attribute.
    CERTSRV_E_BAD_RENEWAL_CERT_ATTRIBUTE = HResultCode.new('CERTSRV_E_BAD_RENEWAL_CERT_ATTRIBUTE', 0x8009400e, 'The request contains an invalid renewal certificate attribute.')

    # (0x8009400f) An attempt was made to open a CA database session, but there are already too many active sessions. The server needs to be configured to allow additional sessions.
    CERTSRV_E_NO_DB_SESSIONS = HResultCode.new('CERTSRV_E_NO_DB_SESSIONS', 0x8009400f, 'An attempt was made to open a CA database session, but there are already too many active sessions. The server needs to be configured to allow additional sessions.')

    # (0x80094010) A memory reference caused a data alignment fault.
    CERTSRV_E_ALIGNMENT_FAULT = HResultCode.new('CERTSRV_E_ALIGNMENT_FAULT', 0x80094010, 'A memory reference caused a data alignment fault.')

    # (0x80094011) The permissions on this CA do not allow the current user to enroll for certificates.
    CERTSRV_E_ENROLL_DENIED = HResultCode.new('CERTSRV_E_ENROLL_DENIED', 0x80094011, 'The permissions on this CA do not allow the current user to enroll for certificates.')

    # (0x80094012) The permissions on the certificate template do not allow the current user to enroll for this type of certificate.
    CERTSRV_E_TEMPLATE_DENIED = HResultCode.new('CERTSRV_E_TEMPLATE_DENIED', 0x80094012, 'The permissions on the certificate template do not allow the current user to enroll for this type of certificate.')

    # (0x80094013) The contacted domain controller cannot support signed Lightweight Directory Access Protocol (LDAP) traffic. Update the domain controller or configure Certificate Services to use SSL for Active Directory access.
    CERTSRV_E_DOWNLEVEL_DC_SSL_OR_UPGRADE = HResultCode.new('CERTSRV_E_DOWNLEVEL_DC_SSL_OR_UPGRADE', 0x80094013, 'The contacted domain controller cannot support signed Lightweight Directory Access Protocol (LDAP) traffic. Update the domain controller or configure Certificate Services to use SSL for Active Directory access.')

    # (0x80094800) The requested certificate template is not supported by this CA.
    CERTSRV_E_UNSUPPORTED_CERT_TYPE = HResultCode.new('CERTSRV_E_UNSUPPORTED_CERT_TYPE', 0x80094800, 'The requested certificate template is not supported by this CA.')

    # (0x80094801) The request contains no certificate template information.
    CERTSRV_E_NO_CERT_TYPE = HResultCode.new('CERTSRV_E_NO_CERT_TYPE', 0x80094801, 'The request contains no certificate template information.')

    # (0x80094802) The request contains conflicting template information.
    CERTSRV_E_TEMPLATE_CONFLICT = HResultCode.new('CERTSRV_E_TEMPLATE_CONFLICT', 0x80094802, 'The request contains conflicting template information.')

    # (0x80094803) The request is missing a required Subject Alternate name extension.
    CERTSRV_E_SUBJECT_ALT_NAME_REQUIRED = HResultCode.new('CERTSRV_E_SUBJECT_ALT_NAME_REQUIRED', 0x80094803, 'The request is missing a required Subject Alternate name extension.')

    # (0x80094804) The request is missing a required private key for archival by the server.
    CERTSRV_E_ARCHIVED_KEY_REQUIRED = HResultCode.new('CERTSRV_E_ARCHIVED_KEY_REQUIRED', 0x80094804, 'The request is missing a required private key for archival by the server.')

    # (0x80094805) The request is missing a required SMIME capabilities extension.
    CERTSRV_E_SMIME_REQUIRED = HResultCode.new('CERTSRV_E_SMIME_REQUIRED', 0x80094805, 'The request is missing a required SMIME capabilities extension.')

    # (0x80094806) The request was made on behalf of a subject other than the caller. The certificate template must be configured to require at least one signature to authorize the request.
    CERTSRV_E_BAD_RENEWAL_SUBJECT = HResultCode.new('CERTSRV_E_BAD_RENEWAL_SUBJECT', 0x80094806, 'The request was made on behalf of a subject other than the caller. The certificate template must be configured to require at least one signature to authorize the request.')

    # (0x80094807) The request template version is newer than the supported template version.
    CERTSRV_E_BAD_TEMPLATE_VERSION = HResultCode.new('CERTSRV_E_BAD_TEMPLATE_VERSION', 0x80094807, 'The request template version is newer than the supported template version.')

    # (0x80094808) The template is missing a required signature policy attribute.
    CERTSRV_E_TEMPLATE_POLICY_REQUIRED = HResultCode.new('CERTSRV_E_TEMPLATE_POLICY_REQUIRED', 0x80094808, 'The template is missing a required signature policy attribute.')

    # (0x80094809) The request is missing required signature policy information.
    CERTSRV_E_SIGNATURE_POLICY_REQUIRED = HResultCode.new('CERTSRV_E_SIGNATURE_POLICY_REQUIRED', 0x80094809, 'The request is missing required signature policy information.')

    # (0x8009480a) The request is missing one or more required signatures.
    CERTSRV_E_SIGNATURE_COUNT = HResultCode.new('CERTSRV_E_SIGNATURE_COUNT', 0x8009480a, 'The request is missing one or more required signatures.')

    # (0x8009480b) One or more signatures did not include the required application or issuance policies. The request is missing one or more required valid signatures.
    CERTSRV_E_SIGNATURE_REJECTED = HResultCode.new('CERTSRV_E_SIGNATURE_REJECTED', 0x8009480b, 'One or more signatures did not include the required application or issuance policies. The request is missing one or more required valid signatures.')

    # (0x8009480c) The request is missing one or more required signature issuance policies.
    CERTSRV_E_ISSUANCE_POLICY_REQUIRED = HResultCode.new('CERTSRV_E_ISSUANCE_POLICY_REQUIRED', 0x8009480c, 'The request is missing one or more required signature issuance policies.')

    # (0x8009480d) The UPN is unavailable and cannot be added to the Subject Alternate name.
    CERTSRV_E_SUBJECT_UPN_REQUIRED = HResultCode.new('CERTSRV_E_SUBJECT_UPN_REQUIRED', 0x8009480d, 'The UPN is unavailable and cannot be added to the Subject Alternate name.')

    # (0x8009480e) The Active Directory GUID is unavailable and cannot be added to the Subject Alternate name.
    CERTSRV_E_SUBJECT_DIRECTORY_GUID_REQUIRED = HResultCode.new('CERTSRV_E_SUBJECT_DIRECTORY_GUID_REQUIRED', 0x8009480e, 'The Active Directory GUID is unavailable and cannot be added to the Subject Alternate name.')

    # (0x8009480f) The Domain Name System (DNS) name is unavailable and cannot be added to the Subject Alternate name.
    CERTSRV_E_SUBJECT_DNS_REQUIRED = HResultCode.new('CERTSRV_E_SUBJECT_DNS_REQUIRED', 0x8009480f, 'The Domain Name System (DNS) name is unavailable and cannot be added to the Subject Alternate name.')

    # (0x80094810) The request includes a private key for archival by the server, but key archival is not enabled for the specified certificate template.
    CERTSRV_E_ARCHIVED_KEY_UNEXPECTED = HResultCode.new('CERTSRV_E_ARCHIVED_KEY_UNEXPECTED', 0x80094810, 'The request includes a private key for archival by the server, but key archival is not enabled for the specified certificate template.')

    # (0x80094811) The public key does not meet the minimum size required by the specified certificate template.
    CERTSRV_E_KEY_LENGTH = HResultCode.new('CERTSRV_E_KEY_LENGTH', 0x80094811, 'The public key does not meet the minimum size required by the specified certificate template.')

    # (0x80094812) The email name is unavailable and cannot be added to the Subject or Subject Alternate name.
    CERTSRV_E_SUBJECT_EMAIL_REQUIRED = HResultCode.new('CERTSRV_E_SUBJECT_EMAIL_REQUIRED', 0x80094812, 'The email name is unavailable and cannot be added to the Subject or Subject Alternate name.')

    # (0x80094813) One or more certificate templates to be enabled on this CA could not be found.
    CERTSRV_E_UNKNOWN_CERT_TYPE = HResultCode.new('CERTSRV_E_UNKNOWN_CERT_TYPE', 0x80094813, 'One or more certificate templates to be enabled on this CA could not be found.')

    # (0x80094814) The certificate template renewal period is longer than the certificate validity period. The template should be reconfigured or the CA certificate renewed.
    CERTSRV_E_CERT_TYPE_OVERLAP = HResultCode.new('CERTSRV_E_CERT_TYPE_OVERLAP', 0x80094814, 'The certificate template renewal period is longer than the certificate validity period. The template should be reconfigured or the CA certificate renewed.')

    # (0x80094815) The certificate template requires too many return authorization (RA) signatures. Only one RA signature is allowed.
    CERTSRV_E_TOO_MANY_SIGNATURES = HResultCode.new('CERTSRV_E_TOO_MANY_SIGNATURES', 0x80094815, 'The certificate template requires too many return authorization (RA) signatures. Only one RA signature is allowed.')

    # (0x80094816) The key used in a renewal request does not match one of the certificates being renewed.
    CERTSRV_E_RENEWAL_BAD_PUBLIC_KEY = HResultCode.new('CERTSRV_E_RENEWAL_BAD_PUBLIC_KEY', 0x80094816, 'The key used in a renewal request does not match one of the certificates being renewed.')

    # (0x80094817) The endorsement key certificate is not valid.
    CERTSRV_E_INVALID_EK = HResultCode.new('CERTSRV_E_INVALID_EK', 0x80094817, 'The endorsement key certificate is not valid.')

    # (0x8009481a) Key attestation did not succeed.
    CERTSRV_E_KEY_ATTESTATION = HResultCode.new('CERTSRV_E_KEY_ATTESTATION', 0x8009481a, 'Key attestation did not succeed.')

    # (0x80095000) The key is not exportable.
    XENROLL_E_KEY_NOT_EXPORTABLE = HResultCode.new('XENROLL_E_KEY_NOT_EXPORTABLE', 0x80095000, 'The key is not exportable.')

    # (0x80095001) You cannot add the root CA certificate into your local store.
    XENROLL_E_CANNOT_ADD_ROOT_CERT = HResultCode.new('XENROLL_E_CANNOT_ADD_ROOT_CERT', 0x80095001, 'You cannot add the root CA certificate into your local store.')

    # (0x80095002) The key archival hash attribute was not found in the response.
    XENROLL_E_RESPONSE_KA_HASH_NOT_FOUND = HResultCode.new('XENROLL_E_RESPONSE_KA_HASH_NOT_FOUND', 0x80095002, 'The key archival hash attribute was not found in the response.')

    # (0x80095003) An unexpected key archival hash attribute was found in the response.
    XENROLL_E_RESPONSE_UNEXPECTED_KA_HASH = HResultCode.new('XENROLL_E_RESPONSE_UNEXPECTED_KA_HASH', 0x80095003, 'An unexpected key archival hash attribute was found in the response.')

    # (0x80095004) There is a key archival hash mismatch between the request and the response.
    XENROLL_E_RESPONSE_KA_HASH_MISMATCH = HResultCode.new('XENROLL_E_RESPONSE_KA_HASH_MISMATCH', 0x80095004, 'There is a key archival hash mismatch between the request and the response.')

    # (0x80095005) Signing certificate cannot include SMIME extension.
    XENROLL_E_KEYSPEC_SMIME_MISMATCH = HResultCode.new('XENROLL_E_KEYSPEC_SMIME_MISMATCH', 0x80095005, 'Signing certificate cannot include SMIME extension.')

    # (0x80096001) A system-level error occurred while verifying trust.
    TRUST_E_SYSTEM_ERROR = HResultCode.new('TRUST_E_SYSTEM_ERROR', 0x80096001, 'A system-level error occurred while verifying trust.')

    # (0x80096002) The certificate for the signer of the message is invalid or not found.
    TRUST_E_NO_SIGNER_CERT = HResultCode.new('TRUST_E_NO_SIGNER_CERT', 0x80096002, 'The certificate for the signer of the message is invalid or not found.')

    # (0x80096003) One of the counter signatures was invalid.
    TRUST_E_COUNTER_SIGNER = HResultCode.new('TRUST_E_COUNTER_SIGNER', 0x80096003, 'One of the counter signatures was invalid.')

    # (0x80096004) The signature of the certificate cannot be verified.
    TRUST_E_CERT_SIGNATURE = HResultCode.new('TRUST_E_CERT_SIGNATURE', 0x80096004, 'The signature of the certificate cannot be verified.')

    # (0x80096005) The time-stamp signature or certificate could not be verified or is malformed.
    TRUST_E_TIME_STAMP = HResultCode.new('TRUST_E_TIME_STAMP', 0x80096005, 'The time-stamp signature or certificate could not be verified or is malformed.')

    # (0x80096010) The digital signature of the object did not verify.
    TRUST_E_BAD_DIGEST = HResultCode.new('TRUST_E_BAD_DIGEST', 0x80096010, 'The digital signature of the object did not verify.')

    # (0x80096019) A certificate's basic constraint extension has not been observed.
    TRUST_E_BASIC_CONSTRAINTS = HResultCode.new('TRUST_E_BASIC_CONSTRAINTS', 0x80096019, 'A certificate\'s basic constraint extension has not been observed.')

    # (0x8009601e) The certificate does not meet or contain the Authenticode financial extensions.
    TRUST_E_FINANCIAL_CRITERIA = HResultCode.new('TRUST_E_FINANCIAL_CRITERIA', 0x8009601e, 'The certificate does not meet or contain the Authenticode financial extensions.')

    # (0x80097001) Tried to reference a part of the file outside the proper range.
    MSSIPOTF_E_OUTOFMEMRANGE = HResultCode.new('MSSIPOTF_E_OUTOFMEMRANGE', 0x80097001, 'Tried to reference a part of the file outside the proper range.')

    # (0x80097002) Could not retrieve an object from the file.
    MSSIPOTF_E_CANTGETOBJECT = HResultCode.new('MSSIPOTF_E_CANTGETOBJECT', 0x80097002, 'Could not retrieve an object from the file.')

    # (0x80097003) Could not find the head table in the file.
    MSSIPOTF_E_NOHEADTABLE = HResultCode.new('MSSIPOTF_E_NOHEADTABLE', 0x80097003, 'Could not find the head table in the file.')

    # (0x80097004) The magic number in the head table is incorrect.
    MSSIPOTF_E_BAD_MAGICNUMBER = HResultCode.new('MSSIPOTF_E_BAD_MAGICNUMBER', 0x80097004, 'The magic number in the head table is incorrect.')

    # (0x80097005) The offset table has incorrect values.
    MSSIPOTF_E_BAD_OFFSET_TABLE = HResultCode.new('MSSIPOTF_E_BAD_OFFSET_TABLE', 0x80097005, 'The offset table has incorrect values.')

    # (0x80097006) Duplicate table tags or the tags are out of alphabetical order.
    MSSIPOTF_E_TABLE_TAGORDER = HResultCode.new('MSSIPOTF_E_TABLE_TAGORDER', 0x80097006, 'Duplicate table tags or the tags are out of alphabetical order.')

    # (0x80097007) A table does not start on a long word boundary.
    MSSIPOTF_E_TABLE_LONGWORD = HResultCode.new('MSSIPOTF_E_TABLE_LONGWORD', 0x80097007, 'A table does not start on a long word boundary.')

    # (0x80097008) First table does not appear after header information.
    MSSIPOTF_E_BAD_FIRST_TABLE_PLACEMENT = HResultCode.new('MSSIPOTF_E_BAD_FIRST_TABLE_PLACEMENT', 0x80097008, 'First table does not appear after header information.')

    # (0x80097009) Two or more tables overlap.
    MSSIPOTF_E_TABLES_OVERLAP = HResultCode.new('MSSIPOTF_E_TABLES_OVERLAP', 0x80097009, 'Two or more tables overlap.')

    # (0x8009700a) Too many pad bytes between tables, or pad bytes are not 0.
    MSSIPOTF_E_TABLE_PADBYTES = HResultCode.new('MSSIPOTF_E_TABLE_PADBYTES', 0x8009700a, 'Too many pad bytes between tables, or pad bytes are not 0.')

    # (0x8009700b) File is too small to contain the last table.
    MSSIPOTF_E_FILETOOSMALL = HResultCode.new('MSSIPOTF_E_FILETOOSMALL', 0x8009700b, 'File is too small to contain the last table.')

    # (0x8009700c) A table checksum is incorrect.
    MSSIPOTF_E_TABLE_CHECKSUM = HResultCode.new('MSSIPOTF_E_TABLE_CHECKSUM', 0x8009700c, 'A table checksum is incorrect.')

    # (0x8009700d) The file checksum is incorrect.
    MSSIPOTF_E_FILE_CHECKSUM = HResultCode.new('MSSIPOTF_E_FILE_CHECKSUM', 0x8009700d, 'The file checksum is incorrect.')

    # (0x80097010) The signature does not have the correct attributes for the policy.
    MSSIPOTF_E_FAILED_POLICY = HResultCode.new('MSSIPOTF_E_FAILED_POLICY', 0x80097010, 'The signature does not have the correct attributes for the policy.')

    # (0x80097011) The file did not pass the hints check.
    MSSIPOTF_E_FAILED_HINTS_CHECK = HResultCode.new('MSSIPOTF_E_FAILED_HINTS_CHECK', 0x80097011, 'The file did not pass the hints check.')

    # (0x80097012) The file is not an OpenType file.
    MSSIPOTF_E_NOT_OPENTYPE = HResultCode.new('MSSIPOTF_E_NOT_OPENTYPE', 0x80097012, 'The file is not an OpenType file.')

    # (0x80097013) Failed on a file operation (such as open, map, read, or write).
    MSSIPOTF_E_FILE = HResultCode.new('MSSIPOTF_E_FILE', 0x80097013, 'Failed on a file operation (such as open, map, read, or write).')

    # (0x80097014) A call to a CryptoAPI function failed.
    MSSIPOTF_E_CRYPT = HResultCode.new('MSSIPOTF_E_CRYPT', 0x80097014, 'A call to a CryptoAPI function failed.')

    # (0x80097015) There is a bad version number in the file.
    MSSIPOTF_E_BADVERSION = HResultCode.new('MSSIPOTF_E_BADVERSION', 0x80097015, 'There is a bad version number in the file.')

    # (0x80097016) The structure of the DSIG table is incorrect.
    MSSIPOTF_E_DSIG_STRUCTURE = HResultCode.new('MSSIPOTF_E_DSIG_STRUCTURE', 0x80097016, 'The structure of the DSIG table is incorrect.')

    # (0x80097017) A check failed in a partially constant table.
    MSSIPOTF_E_PCONST_CHECK = HResultCode.new('MSSIPOTF_E_PCONST_CHECK', 0x80097017, 'A check failed in a partially constant table.')

    # (0x80097018) Some kind of structural error.
    MSSIPOTF_E_STRUCTURE = HResultCode.new('MSSIPOTF_E_STRUCTURE', 0x80097018, 'Some kind of structural error.')

    # (0x80097019) The requested credential requires confirmation.
    ERROR_CRED_REQUIRES_CONFIRMATION = HResultCode.new('ERROR_CRED_REQUIRES_CONFIRMATION', 0x80097019, 'The requested credential requires confirmation.')

    # (0x800b0001) Unknown trust provider.
    TRUST_E_PROVIDER_UNKNOWN = HResultCode.new('TRUST_E_PROVIDER_UNKNOWN', 0x800b0001, 'Unknown trust provider.')

    # (0x800b0002) The trust verification action specified is not supported by the specified trust provider.
    TRUST_E_ACTION_UNKNOWN = HResultCode.new('TRUST_E_ACTION_UNKNOWN', 0x800b0002, 'The trust verification action specified is not supported by the specified trust provider.')

    # (0x800b0003) The form specified for the subject is not one supported or known by the specified trust provider.
    TRUST_E_SUBJECT_FORM_UNKNOWN = HResultCode.new('TRUST_E_SUBJECT_FORM_UNKNOWN', 0x800b0003, 'The form specified for the subject is not one supported or known by the specified trust provider.')

    # (0x800b0004) The subject is not trusted for the specified action.
    TRUST_E_SUBJECT_NOT_TRUSTED = HResultCode.new('TRUST_E_SUBJECT_NOT_TRUSTED', 0x800b0004, 'The subject is not trusted for the specified action.')

    # (0x800b0005) Error due to problem in ASN.1 encoding process.
    DIGSIG_E_ENCODE = HResultCode.new('DIGSIG_E_ENCODE', 0x800b0005, 'Error due to problem in ASN.1 encoding process.')

    # (0x800b0006) Error due to problem in ASN.1 decoding process.
    DIGSIG_E_DECODE = HResultCode.new('DIGSIG_E_DECODE', 0x800b0006, 'Error due to problem in ASN.1 decoding process.')

    # (0x800b0007) Reading/writing extensions where attributes are appropriate, and vice versa.
    DIGSIG_E_EXTENSIBILITY = HResultCode.new('DIGSIG_E_EXTENSIBILITY', 0x800b0007, 'Reading/writing extensions where attributes are appropriate, and vice versa.')

    # (0x800b0008) Unspecified cryptographic failure.
    DIGSIG_E_CRYPTO = HResultCode.new('DIGSIG_E_CRYPTO', 0x800b0008, 'Unspecified cryptographic failure.')

    # (0x800b0009) The size of the data could not be determined.
    PERSIST_E_SIZEDEFINITE = HResultCode.new('PERSIST_E_SIZEDEFINITE', 0x800b0009, 'The size of the data could not be determined.')

    # (0x800b000a) The size of the indefinite-sized data could not be determined.
    PERSIST_E_SIZEINDEFINITE = HResultCode.new('PERSIST_E_SIZEINDEFINITE', 0x800b000a, 'The size of the indefinite-sized data could not be determined.')

    # (0x800b000b) This object does not read and write self-sizing data.
    PERSIST_E_NOTSELFSIZING = HResultCode.new('PERSIST_E_NOTSELFSIZING', 0x800b000b, 'This object does not read and write self-sizing data.')

    # (0x800b0100) No signature was present in the subject.
    TRUST_E_NOSIGNATURE = HResultCode.new('TRUST_E_NOSIGNATURE', 0x800b0100, 'No signature was present in the subject.')

    # (0x800b0101) A required certificate is not within its validity period when verifying against the current system clock or the time stamp in the signed file.
    CERT_E_EXPIRED = HResultCode.new('CERT_E_EXPIRED', 0x800b0101, 'A required certificate is not within its validity period when verifying against the current system clock or the time stamp in the signed file.')

    # (0x800b0102) The validity periods of the certification chain do not nest correctly.
    CERT_E_VALIDITYPERIODNESTING = HResultCode.new('CERT_E_VALIDITYPERIODNESTING', 0x800b0102, 'The validity periods of the certification chain do not nest correctly.')

    # (0x800b0103) A certificate that can only be used as an end entity is being used as a CA or vice versa.
    CERT_E_ROLE = HResultCode.new('CERT_E_ROLE', 0x800b0103, 'A certificate that can only be used as an end entity is being used as a CA or vice versa.')

    # (0x800b0104) A path length constraint in the certification chain has been violated.
    CERT_E_PATHLENCONST = HResultCode.new('CERT_E_PATHLENCONST', 0x800b0104, 'A path length constraint in the certification chain has been violated.')

    # (0x800b0105) A certificate contains an unknown extension that is marked "critical".
    CERT_E_CRITICAL = HResultCode.new('CERT_E_CRITICAL', 0x800b0105, 'A certificate contains an unknown extension that is marked "critical".')

    # (0x800b0106) A certificate is being used for a purpose other than the ones specified by its CA.
    CERT_E_PURPOSE = HResultCode.new('CERT_E_PURPOSE', 0x800b0106, 'A certificate is being used for a purpose other than the ones specified by its CA.')

    # (0x800b0107) A parent of a given certificate did not issue that child certificate.
    CERT_E_ISSUERCHAINING = HResultCode.new('CERT_E_ISSUERCHAINING', 0x800b0107, 'A parent of a given certificate did not issue that child certificate.')

    # (0x800b0108) A certificate is missing or has an empty value for an important field, such as a subject or issuer name.
    CERT_E_MALFORMED = HResultCode.new('CERT_E_MALFORMED', 0x800b0108, 'A certificate is missing or has an empty value for an important field, such as a subject or issuer name.')

    # (0x800b0109) A certificate chain processed, but terminated in a root certificate that is not trusted by the trust provider.
    CERT_E_UNTRUSTEDROOT = HResultCode.new('CERT_E_UNTRUSTEDROOT', 0x800b0109, 'A certificate chain processed, but terminated in a root certificate that is not trusted by the trust provider.')

    # (0x800b010a) A certificate chain could not be built to a trusted root authority.
    CERT_E_CHAINING = HResultCode.new('CERT_E_CHAINING', 0x800b010a, 'A certificate chain could not be built to a trusted root authority.')

    # (0x800b010b) Generic trust failure.
    TRUST_E_FAIL = HResultCode.new('TRUST_E_FAIL', 0x800b010b, 'Generic trust failure.')

    # (0x800b010c) A certificate was explicitly revoked by its issuer. If the certificate is Microsoft Windows PCA 2010, then the driver was signed by a certificate no longer recognized by Windows.<3>
    CERT_E_REVOKED = HResultCode.new('CERT_E_REVOKED', 0x800b010c, 'A certificate was explicitly revoked by its issuer. If the certificate is Microsoft Windows PCA 2010, then the driver was signed by a certificate no longer recognized by Windows.<3>')

    # (0x800b010d) The certification path terminates with the test root that is not trusted with the current policy settings.
    CERT_E_UNTRUSTEDTESTROOT = HResultCode.new('CERT_E_UNTRUSTEDTESTROOT', 0x800b010d, 'The certification path terminates with the test root that is not trusted with the current policy settings.')

    # (0x800b010e) The revocation process could not continue—the certificates could not be checked.
    CERT_E_REVOCATION_FAILURE = HResultCode.new('CERT_E_REVOCATION_FAILURE', 0x800b010e, 'The revocation process could not continue—the certificates could not be checked.')

    # (0x800b010f) The certificate's CN name does not match the passed value.
    CERT_E_CN_NO_MATCH = HResultCode.new('CERT_E_CN_NO_MATCH', 0x800b010f, 'The certificate\'s CN name does not match the passed value.')

    # (0x800b0110) The certificate is not valid for the requested usage.
    CERT_E_WRONG_USAGE = HResultCode.new('CERT_E_WRONG_USAGE', 0x800b0110, 'The certificate is not valid for the requested usage.')

    # (0x800b0111) The certificate was explicitly marked as untrusted by the user.
    TRUST_E_EXPLICIT_DISTRUST = HResultCode.new('TRUST_E_EXPLICIT_DISTRUST', 0x800b0111, 'The certificate was explicitly marked as untrusted by the user.')

    # (0x800b0112) A certification chain processed correctly, but one of the CA certificates is not trusted by the policy provider.
    CERT_E_UNTRUSTEDCA = HResultCode.new('CERT_E_UNTRUSTEDCA', 0x800b0112, 'A certification chain processed correctly, but one of the CA certificates is not trusted by the policy provider.')

    # (0x800b0113) The certificate has invalid policy.
    CERT_E_INVALID_POLICY = HResultCode.new('CERT_E_INVALID_POLICY', 0x800b0113, 'The certificate has invalid policy.')

    # (0x800b0114) The certificate has an invalid name. The name is not included in the permitted list or is explicitly excluded.
    CERT_E_INVALID_NAME = HResultCode.new('CERT_E_INVALID_NAME', 0x800b0114, 'The certificate has an invalid name. The name is not included in the permitted list or is explicitly excluded.')

    # (0x800d0003) The maximum filebitrate value specified is greater than the server's configured maximum bandwidth.
    NS_W_SERVER_BANDWIDTH_LIMIT = HResultCode.new('NS_W_SERVER_BANDWIDTH_LIMIT', 0x800d0003, 'The maximum filebitrate value specified is greater than the server\'s configured maximum bandwidth.')

    # (0x800d0004) The maximum bandwidth value specified is less than the maximum filebitrate.
    NS_W_FILE_BANDWIDTH_LIMIT = HResultCode.new('NS_W_FILE_BANDWIDTH_LIMIT', 0x800d0004, 'The maximum bandwidth value specified is less than the maximum filebitrate.')

    # (0x800d0060) Unknown %1 event encountered.
    NS_W_UNKNOWN_EVENT = HResultCode.new('NS_W_UNKNOWN_EVENT', 0x800d0060, 'Unknown %1 event encountered.')

    # (0x800d0199) Disk %1 ( %2 ) on Content Server %3, will be failed because it is catatonic.
    NS_I_CATATONIC_FAILURE = HResultCode.new('NS_I_CATATONIC_FAILURE', 0x800d0199, 'Disk %1 ( %2 ) on Content Server %3, will be failed because it is catatonic.')

    # (0x800d019a) Disk %1 ( %2 ) on Content Server %3, auto online from catatonic state.
    NS_I_CATATONIC_AUTO_UNFAIL = HResultCode.new('NS_I_CATATONIC_AUTO_UNFAIL', 0x800d019a, 'Disk %1 ( %2 ) on Content Server %3, auto online from catatonic state.')

    # (0x800f0000) A non-empty line was encountered in the INF before the start of a section.
    SPAPI_E_EXPECTED_SECTION_NAME = HResultCode.new('SPAPI_E_EXPECTED_SECTION_NAME', 0x800f0000, 'A non-empty line was encountered in the INF before the start of a section.')

    # (0x800f0001) A section name marker in the information file (INF) is not complete or does not exist on a line by itself.
    SPAPI_E_BAD_SECTION_NAME_LINE = HResultCode.new('SPAPI_E_BAD_SECTION_NAME_LINE', 0x800f0001, 'A section name marker in the information file (INF) is not complete or does not exist on a line by itself.')

    # (0x800f0002) An INF section was encountered whose name exceeds the maximum section name length.
    SPAPI_E_SECTION_NAME_TOO_LONG = HResultCode.new('SPAPI_E_SECTION_NAME_TOO_LONG', 0x800f0002, 'An INF section was encountered whose name exceeds the maximum section name length.')

    # (0x800f0003) The syntax of the INF is invalid.
    SPAPI_E_GENERAL_SYNTAX = HResultCode.new('SPAPI_E_GENERAL_SYNTAX', 0x800f0003, 'The syntax of the INF is invalid.')

    # (0x800f0100) The style of the INF is different than what was requested.
    SPAPI_E_WRONG_INF_STYLE = HResultCode.new('SPAPI_E_WRONG_INF_STYLE', 0x800f0100, 'The style of the INF is different than what was requested.')

    # (0x800f0101) The required section was not found in the INF.
    SPAPI_E_SECTION_NOT_FOUND = HResultCode.new('SPAPI_E_SECTION_NOT_FOUND', 0x800f0101, 'The required section was not found in the INF.')

    # (0x800f0102) The required line was not found in the INF.
    SPAPI_E_LINE_NOT_FOUND = HResultCode.new('SPAPI_E_LINE_NOT_FOUND', 0x800f0102, 'The required line was not found in the INF.')

    # (0x800f0103) The files affected by the installation of this file queue have not been backed up for uninstall.
    SPAPI_E_NO_BACKUP = HResultCode.new('SPAPI_E_NO_BACKUP', 0x800f0103, 'The files affected by the installation of this file queue have not been backed up for uninstall.')

    # (0x800f0200) The INF or the device information set or element does not have an associated install class.
    SPAPI_E_NO_ASSOCIATED_CLASS = HResultCode.new('SPAPI_E_NO_ASSOCIATED_CLASS', 0x800f0200, 'The INF or the device information set or element does not have an associated install class.')

    # (0x800f0201) The INF or the device information set or element does not match the specified install class.
    SPAPI_E_CLASS_MISMATCH = HResultCode.new('SPAPI_E_CLASS_MISMATCH', 0x800f0201, 'The INF or the device information set or element does not match the specified install class.')

    # (0x800f0202) An existing device was found that is a duplicate of the device being manually installed.
    SPAPI_E_DUPLICATE_FOUND = HResultCode.new('SPAPI_E_DUPLICATE_FOUND', 0x800f0202, 'An existing device was found that is a duplicate of the device being manually installed.')

    # (0x800f0203) There is no driver selected for the device information set or element.
    SPAPI_E_NO_DRIVER_SELECTED = HResultCode.new('SPAPI_E_NO_DRIVER_SELECTED', 0x800f0203, 'There is no driver selected for the device information set or element.')

    # (0x800f0204) The requested device registry key does not exist.
    SPAPI_E_KEY_DOES_NOT_EXIST = HResultCode.new('SPAPI_E_KEY_DOES_NOT_EXIST', 0x800f0204, 'The requested device registry key does not exist.')

    # (0x800f0205) The device instance name is invalid.
    SPAPI_E_INVALID_DEVINST_NAME = HResultCode.new('SPAPI_E_INVALID_DEVINST_NAME', 0x800f0205, 'The device instance name is invalid.')

    # (0x800f0206) The install class is not present or is invalid.
    SPAPI_E_INVALID_CLASS = HResultCode.new('SPAPI_E_INVALID_CLASS', 0x800f0206, 'The install class is not present or is invalid.')

    # (0x800f0207) The device instance cannot be created because it already exists.
    SPAPI_E_DEVINST_ALREADY_EXISTS = HResultCode.new('SPAPI_E_DEVINST_ALREADY_EXISTS', 0x800f0207, 'The device instance cannot be created because it already exists.')

    # (0x800f0208) The operation cannot be performed on a device information element that has not been registered.
    SPAPI_E_DEVINFO_NOT_REGISTERED = HResultCode.new('SPAPI_E_DEVINFO_NOT_REGISTERED', 0x800f0208, 'The operation cannot be performed on a device information element that has not been registered.')

    # (0x800f0209) The device property code is invalid.
    SPAPI_E_INVALID_REG_PROPERTY = HResultCode.new('SPAPI_E_INVALID_REG_PROPERTY', 0x800f0209, 'The device property code is invalid.')

    # (0x800f020a) The INF from which a driver list is to be built does not exist.
    SPAPI_E_NO_INF = HResultCode.new('SPAPI_E_NO_INF', 0x800f020a, 'The INF from which a driver list is to be built does not exist.')

    # (0x800f020b) The device instance does not exist in the hardware tree.
    SPAPI_E_NO_SUCH_DEVINST = HResultCode.new('SPAPI_E_NO_SUCH_DEVINST', 0x800f020b, 'The device instance does not exist in the hardware tree.')

    # (0x800f020c) The icon representing this install class cannot be loaded.
    SPAPI_E_CANT_LOAD_CLASS_ICON = HResultCode.new('SPAPI_E_CANT_LOAD_CLASS_ICON', 0x800f020c, 'The icon representing this install class cannot be loaded.')

    # (0x800f020d) The class installer registry entry is invalid.
    SPAPI_E_INVALID_CLASS_INSTALLER = HResultCode.new('SPAPI_E_INVALID_CLASS_INSTALLER', 0x800f020d, 'The class installer registry entry is invalid.')

    # (0x800f020e) The class installer has indicated that the default action should be performed for this installation request.
    SPAPI_E_DI_DO_DEFAULT = HResultCode.new('SPAPI_E_DI_DO_DEFAULT', 0x800f020e, 'The class installer has indicated that the default action should be performed for this installation request.')

    # (0x800f020f) The operation does not require any files to be copied.
    SPAPI_E_DI_NOFILECOPY = HResultCode.new('SPAPI_E_DI_NOFILECOPY', 0x800f020f, 'The operation does not require any files to be copied.')

    # (0x800f0210) The specified hardware profile does not exist.
    SPAPI_E_INVALID_HWPROFILE = HResultCode.new('SPAPI_E_INVALID_HWPROFILE', 0x800f0210, 'The specified hardware profile does not exist.')

    # (0x800f0211) There is no device information element currently selected for this device information set.
    SPAPI_E_NO_DEVICE_SELECTED = HResultCode.new('SPAPI_E_NO_DEVICE_SELECTED', 0x800f0211, 'There is no device information element currently selected for this device information set.')

    # (0x800f0212) The operation cannot be performed because the device information set is locked.
    SPAPI_E_DEVINFO_LIST_LOCKED = HResultCode.new('SPAPI_E_DEVINFO_LIST_LOCKED', 0x800f0212, 'The operation cannot be performed because the device information set is locked.')

    # (0x800f0213) The operation cannot be performed because the device information element is locked.
    SPAPI_E_DEVINFO_DATA_LOCKED = HResultCode.new('SPAPI_E_DEVINFO_DATA_LOCKED', 0x800f0213, 'The operation cannot be performed because the device information element is locked.')

    # (0x800f0214) The specified path does not contain any applicable device INFs.
    SPAPI_E_DI_BAD_PATH = HResultCode.new('SPAPI_E_DI_BAD_PATH', 0x800f0214, 'The specified path does not contain any applicable device INFs.')

    # (0x800f0215) No class installer parameters have been set for the device information set or element.
    SPAPI_E_NO_CLASSINSTALL_PARAMS = HResultCode.new('SPAPI_E_NO_CLASSINSTALL_PARAMS', 0x800f0215, 'No class installer parameters have been set for the device information set or element.')

    # (0x800f0216) The operation cannot be performed because the file queue is locked.
    SPAPI_E_FILEQUEUE_LOCKED = HResultCode.new('SPAPI_E_FILEQUEUE_LOCKED', 0x800f0216, 'The operation cannot be performed because the file queue is locked.')

    # (0x800f0217) A service installation section in this INF is invalid.
    SPAPI_E_BAD_SERVICE_INSTALLSECT = HResultCode.new('SPAPI_E_BAD_SERVICE_INSTALLSECT', 0x800f0217, 'A service installation section in this INF is invalid.')

    # (0x800f0218) There is no class driver list for the device information element.
    SPAPI_E_NO_CLASS_DRIVER_LIST = HResultCode.new('SPAPI_E_NO_CLASS_DRIVER_LIST', 0x800f0218, 'There is no class driver list for the device information element.')

    # (0x800f0219) The installation failed because a function driver was not specified for this device instance.
    SPAPI_E_NO_ASSOCIATED_SERVICE = HResultCode.new('SPAPI_E_NO_ASSOCIATED_SERVICE', 0x800f0219, 'The installation failed because a function driver was not specified for this device instance.')

    # (0x800f021a) There is presently no default device interface designated for this interface class.
    SPAPI_E_NO_DEFAULT_DEVICE_INTERFACE = HResultCode.new('SPAPI_E_NO_DEFAULT_DEVICE_INTERFACE', 0x800f021a, 'There is presently no default device interface designated for this interface class.')

    # (0x800f021b) The operation cannot be performed because the device interface is currently active.
    SPAPI_E_DEVICE_INTERFACE_ACTIVE = HResultCode.new('SPAPI_E_DEVICE_INTERFACE_ACTIVE', 0x800f021b, 'The operation cannot be performed because the device interface is currently active.')

    # (0x800f021c) The operation cannot be performed because the device interface has been removed from the system.
    SPAPI_E_DEVICE_INTERFACE_REMOVED = HResultCode.new('SPAPI_E_DEVICE_INTERFACE_REMOVED', 0x800f021c, 'The operation cannot be performed because the device interface has been removed from the system.')

    # (0x800f021d) An interface installation section in this INF is invalid.
    SPAPI_E_BAD_INTERFACE_INSTALLSECT = HResultCode.new('SPAPI_E_BAD_INTERFACE_INSTALLSECT', 0x800f021d, 'An interface installation section in this INF is invalid.')

    # (0x800f021e) This interface class does not exist in the system.
    SPAPI_E_NO_SUCH_INTERFACE_CLASS = HResultCode.new('SPAPI_E_NO_SUCH_INTERFACE_CLASS', 0x800f021e, 'This interface class does not exist in the system.')

    # (0x800f021f) The reference string supplied for this interface device is invalid.
    SPAPI_E_INVALID_REFERENCE_STRING = HResultCode.new('SPAPI_E_INVALID_REFERENCE_STRING', 0x800f021f, 'The reference string supplied for this interface device is invalid.')

    # (0x800f0220) The specified machine name does not conform to Universal Naming Convention (UNCs).
    SPAPI_E_INVALID_MACHINENAME = HResultCode.new('SPAPI_E_INVALID_MACHINENAME', 0x800f0220, 'The specified machine name does not conform to Universal Naming Convention (UNCs).')

    # (0x800f0221) A general remote communication error occurred.
    SPAPI_E_REMOTE_COMM_FAILURE = HResultCode.new('SPAPI_E_REMOTE_COMM_FAILURE', 0x800f0221, 'A general remote communication error occurred.')

    # (0x800f0222) The machine selected for remote communication is not available at this time.
    SPAPI_E_MACHINE_UNAVAILABLE = HResultCode.new('SPAPI_E_MACHINE_UNAVAILABLE', 0x800f0222, 'The machine selected for remote communication is not available at this time.')

    # (0x800f0223) The Plug and Play service is not available on the remote machine.
    SPAPI_E_NO_CONFIGMGR_SERVICES = HResultCode.new('SPAPI_E_NO_CONFIGMGR_SERVICES', 0x800f0223, 'The Plug and Play service is not available on the remote machine.')

    # (0x800f0224) The property page provider registry entry is invalid.
    SPAPI_E_INVALID_PROPPAGE_PROVIDER = HResultCode.new('SPAPI_E_INVALID_PROPPAGE_PROVIDER', 0x800f0224, 'The property page provider registry entry is invalid.')

    # (0x800f0225) The requested device interface is not present in the system.
    SPAPI_E_NO_SUCH_DEVICE_INTERFACE = HResultCode.new('SPAPI_E_NO_SUCH_DEVICE_INTERFACE', 0x800f0225, 'The requested device interface is not present in the system.')

    # (0x800f0226) The device's co-installer has additional work to perform after installation is complete.
    SPAPI_E_DI_POSTPROCESSING_REQUIRED = HResultCode.new('SPAPI_E_DI_POSTPROCESSING_REQUIRED', 0x800f0226, 'The device\'s co-installer has additional work to perform after installation is complete.')

    # (0x800f0227) The device's co-installer is invalid.
    SPAPI_E_INVALID_COINSTALLER = HResultCode.new('SPAPI_E_INVALID_COINSTALLER', 0x800f0227, 'The device\'s co-installer is invalid.')

    # (0x800f0228) There are no compatible drivers for this device.
    SPAPI_E_NO_COMPAT_DRIVERS = HResultCode.new('SPAPI_E_NO_COMPAT_DRIVERS', 0x800f0228, 'There are no compatible drivers for this device.')

    # (0x800f0229) There is no icon that represents this device or device type.
    SPAPI_E_NO_DEVICE_ICON = HResultCode.new('SPAPI_E_NO_DEVICE_ICON', 0x800f0229, 'There is no icon that represents this device or device type.')

    # (0x800f022a) A logical configuration specified in this INF is invalid.
    SPAPI_E_INVALID_INF_LOGCONFIG = HResultCode.new('SPAPI_E_INVALID_INF_LOGCONFIG', 0x800f022a, 'A logical configuration specified in this INF is invalid.')

    # (0x800f022b) The class installer has denied the request to install or upgrade this device.
    SPAPI_E_DI_DONT_INSTALL = HResultCode.new('SPAPI_E_DI_DONT_INSTALL', 0x800f022b, 'The class installer has denied the request to install or upgrade this device.')

    # (0x800f022c) One of the filter drivers installed for this device is invalid.
    SPAPI_E_INVALID_FILTER_DRIVER = HResultCode.new('SPAPI_E_INVALID_FILTER_DRIVER', 0x800f022c, 'One of the filter drivers installed for this device is invalid.')

    # (0x800f022d) The driver selected for this device does not support Windows XP operating system.
    SPAPI_E_NON_WINDOWS_NT_DRIVER = HResultCode.new('SPAPI_E_NON_WINDOWS_NT_DRIVER', 0x800f022d, 'The driver selected for this device does not support Windows XP operating system.')

    # (0x800f022e) The driver selected for this device does not support Windows.
    SPAPI_E_NON_WINDOWS_DRIVER = HResultCode.new('SPAPI_E_NON_WINDOWS_DRIVER', 0x800f022e, 'The driver selected for this device does not support Windows.')

    # (0x800f022f) The third-party INF does not contain digital signature information.
    SPAPI_E_NO_CATALOG_FOR_OEM_INF = HResultCode.new('SPAPI_E_NO_CATALOG_FOR_OEM_INF', 0x800f022f, 'The third-party INF does not contain digital signature information.')

    # (0x800f0230) An invalid attempt was made to use a device installation file queue for verification of digital signatures relative to other platforms.
    SPAPI_E_DEVINSTALL_QUEUE_NONNATIVE = HResultCode.new('SPAPI_E_DEVINSTALL_QUEUE_NONNATIVE', 0x800f0230, 'An invalid attempt was made to use a device installation file queue for verification of digital signatures relative to other platforms.')

    # (0x800f0231) The device cannot be disabled.
    SPAPI_E_NOT_DISABLEABLE = HResultCode.new('SPAPI_E_NOT_DISABLEABLE', 0x800f0231, 'The device cannot be disabled.')

    # (0x800f0232) The device could not be dynamically removed.
    SPAPI_E_CANT_REMOVE_DEVINST = HResultCode.new('SPAPI_E_CANT_REMOVE_DEVINST', 0x800f0232, 'The device could not be dynamically removed.')

    # (0x800f0233) Cannot copy to specified target.
    SPAPI_E_INVALID_TARGET = HResultCode.new('SPAPI_E_INVALID_TARGET', 0x800f0233, 'Cannot copy to specified target.')

    # (0x800f0234) Driver is not intended for this platform.
    SPAPI_E_DRIVER_NONNATIVE = HResultCode.new('SPAPI_E_DRIVER_NONNATIVE', 0x800f0234, 'Driver is not intended for this platform.')

    # (0x800f0235) Operation not allowed in WOW64.
    SPAPI_E_IN_WOW64 = HResultCode.new('SPAPI_E_IN_WOW64', 0x800f0235, 'Operation not allowed in WOW64.')

    # (0x800f0236) The operation involving unsigned file copying was rolled back, so that a system restore point could be set.
    SPAPI_E_SET_SYSTEM_RESTORE_POINT = HResultCode.new('SPAPI_E_SET_SYSTEM_RESTORE_POINT', 0x800f0236, 'The operation involving unsigned file copying was rolled back, so that a system restore point could be set.')

    # (0x800f0237) An INF was copied into the Windows INF directory in an improper manner.
    SPAPI_E_INCORRECTLY_COPIED_INF = HResultCode.new('SPAPI_E_INCORRECTLY_COPIED_INF', 0x800f0237, 'An INF was copied into the Windows INF directory in an improper manner.')

    # (0x800f0238) The Security Configuration Editor (SCE) APIs have been disabled on this embedded product.
    SPAPI_E_SCE_DISABLED = HResultCode.new('SPAPI_E_SCE_DISABLED', 0x800f0238, 'The Security Configuration Editor (SCE) APIs have been disabled on this embedded product.')

    # (0x800f0239) An unknown exception was encountered.
    SPAPI_E_UNKNOWN_EXCEPTION = HResultCode.new('SPAPI_E_UNKNOWN_EXCEPTION', 0x800f0239, 'An unknown exception was encountered.')

    # (0x800f023a) A problem was encountered when accessing the Plug and Play registry database.
    SPAPI_E_PNP_REGISTRY_ERROR = HResultCode.new('SPAPI_E_PNP_REGISTRY_ERROR', 0x800f023a, 'A problem was encountered when accessing the Plug and Play registry database.')

    # (0x800f023b) The requested operation is not supported for a remote machine.
    SPAPI_E_REMOTE_REQUEST_UNSUPPORTED = HResultCode.new('SPAPI_E_REMOTE_REQUEST_UNSUPPORTED', 0x800f023b, 'The requested operation is not supported for a remote machine.')

    # (0x800f023c) The specified file is not an installed original equipment manufacturer (OEM) INF.
    SPAPI_E_NOT_AN_INSTALLED_OEM_INF = HResultCode.new('SPAPI_E_NOT_AN_INSTALLED_OEM_INF', 0x800f023c, 'The specified file is not an installed original equipment manufacturer (OEM) INF.')

    # (0x800f023d) One or more devices are presently installed using the specified INF.
    SPAPI_E_INF_IN_USE_BY_DEVICES = HResultCode.new('SPAPI_E_INF_IN_USE_BY_DEVICES', 0x800f023d, 'One or more devices are presently installed using the specified INF.')

    # (0x800f023e) The requested device install operation is obsolete.
    SPAPI_E_DI_FUNCTION_OBSOLETE = HResultCode.new('SPAPI_E_DI_FUNCTION_OBSOLETE', 0x800f023e, 'The requested device install operation is obsolete.')

    # (0x800f023f) A file could not be verified because it does not have an associated catalog signed via Authenticode.
    SPAPI_E_NO_AUTHENTICODE_CATALOG = HResultCode.new('SPAPI_E_NO_AUTHENTICODE_CATALOG', 0x800f023f, 'A file could not be verified because it does not have an associated catalog signed via Authenticode.')

    # (0x800f0240) Authenticode signature verification is not supported for the specified INF.
    SPAPI_E_AUTHENTICODE_DISALLOWED = HResultCode.new('SPAPI_E_AUTHENTICODE_DISALLOWED', 0x800f0240, 'Authenticode signature verification is not supported for the specified INF.')

    # (0x800f0241) The INF was signed with an Authenticode catalog from a trusted publisher.
    SPAPI_E_AUTHENTICODE_TRUSTED_PUBLISHER = HResultCode.new('SPAPI_E_AUTHENTICODE_TRUSTED_PUBLISHER', 0x800f0241, 'The INF was signed with an Authenticode catalog from a trusted publisher.')

    # (0x800f0242) The publisher of an Authenticode-signed catalog has not yet been established as trusted.
    SPAPI_E_AUTHENTICODE_TRUST_NOT_ESTABLISHED = HResultCode.new('SPAPI_E_AUTHENTICODE_TRUST_NOT_ESTABLISHED', 0x800f0242, 'The publisher of an Authenticode-signed catalog has not yet been established as trusted.')

    # (0x800f0243) The publisher of an Authenticode-signed catalog was not established as trusted.
    SPAPI_E_AUTHENTICODE_PUBLISHER_NOT_TRUSTED = HResultCode.new('SPAPI_E_AUTHENTICODE_PUBLISHER_NOT_TRUSTED', 0x800f0243, 'The publisher of an Authenticode-signed catalog was not established as trusted.')

    # (0x800f0244) The software was tested for compliance with Windows logo requirements on a different version of Windows and might not be compatible with this version.
    SPAPI_E_SIGNATURE_OSATTRIBUTE_MISMATCH = HResultCode.new('SPAPI_E_SIGNATURE_OSATTRIBUTE_MISMATCH', 0x800f0244, 'The software was tested for compliance with Windows logo requirements on a different version of Windows and might not be compatible with this version.')

    # (0x800f0245) The file can be validated only by a catalog signed via Authenticode.
    SPAPI_E_ONLY_VALIDATE_VIA_AUTHENTICODE = HResultCode.new('SPAPI_E_ONLY_VALIDATE_VIA_AUTHENTICODE', 0x800f0245, 'The file can be validated only by a catalog signed via Authenticode.')

    # (0x800f0246) One of the installers for this device cannot perform the installation at this time.
    SPAPI_E_DEVICE_INSTALLER_NOT_READY = HResultCode.new('SPAPI_E_DEVICE_INSTALLER_NOT_READY', 0x800f0246, 'One of the installers for this device cannot perform the installation at this time.')

    # (0x800f0247) A problem was encountered while attempting to add the driver to the store.
    SPAPI_E_DRIVER_STORE_ADD_FAILED = HResultCode.new('SPAPI_E_DRIVER_STORE_ADD_FAILED', 0x800f0247, 'A problem was encountered while attempting to add the driver to the store.')

    # (0x800f0248) The installation of this device is forbidden by system policy. Contact your system administrator.
    SPAPI_E_DEVICE_INSTALL_BLOCKED = HResultCode.new('SPAPI_E_DEVICE_INSTALL_BLOCKED', 0x800f0248, 'The installation of this device is forbidden by system policy. Contact your system administrator.')

    # (0x800f0249) The installation of this driver is forbidden by system policy. Contact your system administrator.
    SPAPI_E_DRIVER_INSTALL_BLOCKED = HResultCode.new('SPAPI_E_DRIVER_INSTALL_BLOCKED', 0x800f0249, 'The installation of this driver is forbidden by system policy. Contact your system administrator.')

    # (0x800f024a) The specified INF is the wrong type for this operation.
    SPAPI_E_WRONG_INF_TYPE = HResultCode.new('SPAPI_E_WRONG_INF_TYPE', 0x800f024a, 'The specified INF is the wrong type for this operation.')

    # (0x800f024b) The hash for the file is not present in the specified catalog file. The file is likely corrupt or the victim of tampering.
    SPAPI_E_FILE_HASH_NOT_IN_CATALOG = HResultCode.new('SPAPI_E_FILE_HASH_NOT_IN_CATALOG', 0x800f024b, 'The hash for the file is not present in the specified catalog file. The file is likely corrupt or the victim of tampering.')

    # (0x800f024c) A problem was encountered while attempting to delete the driver from the store.
    SPAPI_E_DRIVER_STORE_DELETE_FAILED = HResultCode.new('SPAPI_E_DRIVER_STORE_DELETE_FAILED', 0x800f024c, 'A problem was encountered while attempting to delete the driver from the store.')

    # (0x800f0300) An unrecoverable stack overflow was encountered.
    SPAPI_E_UNRECOVERABLE_STACK_OVERFLOW = HResultCode.new('SPAPI_E_UNRECOVERABLE_STACK_OVERFLOW', 0x800f0300, 'An unrecoverable stack overflow was encountered.')

    # (0x800f1000) No installed components were detected.
    SPAPI_E_ERROR_NOT_INSTALLED = HResultCode.new('SPAPI_E_ERROR_NOT_INSTALLED', 0x800f1000, 'No installed components were detected.')

    # (0x80100001) An internal consistency check failed.
    SCARD_F_INTERNAL_ERROR = HResultCode.new('SCARD_F_INTERNAL_ERROR', 0x80100001, 'An internal consistency check failed.')

    # (0x80100002) The action was canceled by an SCardCancel request.
    SCARD_E_CANCELLED = HResultCode.new('SCARD_E_CANCELLED', 0x80100002, 'The action was canceled by an SCardCancel request.')

    # (0x80100003) The supplied handle was invalid.
    SCARD_E_INVALID_HANDLE = HResultCode.new('SCARD_E_INVALID_HANDLE', 0x80100003, 'The supplied handle was invalid.')

    # (0x80100004) One or more of the supplied parameters could not be properly interpreted.
    SCARD_E_INVALID_PARAMETER = HResultCode.new('SCARD_E_INVALID_PARAMETER', 0x80100004, 'One or more of the supplied parameters could not be properly interpreted.')

    # (0x80100005) Registry startup information is missing or invalid.
    SCARD_E_INVALID_TARGET = HResultCode.new('SCARD_E_INVALID_TARGET', 0x80100005, 'Registry startup information is missing or invalid.')

    # (0x80100006) Not enough memory available to complete this command.
    SCARD_E_NO_MEMORY = HResultCode.new('SCARD_E_NO_MEMORY', 0x80100006, 'Not enough memory available to complete this command.')

    # (0x80100007) An internal consistency timer has expired.
    SCARD_F_WAITED_TOO_LONG = HResultCode.new('SCARD_F_WAITED_TOO_LONG', 0x80100007, 'An internal consistency timer has expired.')

    # (0x80100008) The data buffer to receive returned data is too small for the returned data.
    SCARD_E_INSUFFICIENT_BUFFER = HResultCode.new('SCARD_E_INSUFFICIENT_BUFFER', 0x80100008, 'The data buffer to receive returned data is too small for the returned data.')

    # (0x80100009) The specified reader name is not recognized.
    SCARD_E_UNKNOWN_READER = HResultCode.new('SCARD_E_UNKNOWN_READER', 0x80100009, 'The specified reader name is not recognized.')

    # (0x8010000a) The user-specified time-out value has expired.
    SCARD_E_TIMEOUT = HResultCode.new('SCARD_E_TIMEOUT', 0x8010000a, 'The user-specified time-out value has expired.')

    # (0x8010000b) The smart card cannot be accessed because of other connections outstanding.
    SCARD_E_SHARING_VIOLATION = HResultCode.new('SCARD_E_SHARING_VIOLATION', 0x8010000b, 'The smart card cannot be accessed because of other connections outstanding.')

    # (0x8010000c) The operation requires a smart card, but no smart card is currently in the device.
    SCARD_E_NO_SMARTCARD = HResultCode.new('SCARD_E_NO_SMARTCARD', 0x8010000c, 'The operation requires a smart card, but no smart card is currently in the device.')

    # (0x8010000d) The specified smart card name is not recognized.
    SCARD_E_UNKNOWN_CARD = HResultCode.new('SCARD_E_UNKNOWN_CARD', 0x8010000d, 'The specified smart card name is not recognized.')

    # (0x8010000e) The system could not dispose of the media in the requested manner.
    SCARD_E_CANT_DISPOSE = HResultCode.new('SCARD_E_CANT_DISPOSE', 0x8010000e, 'The system could not dispose of the media in the requested manner.')

    # (0x8010000f) The requested protocols are incompatible with the protocol currently in use with the smart card.
    SCARD_E_PROTO_MISMATCH = HResultCode.new('SCARD_E_PROTO_MISMATCH', 0x8010000f, 'The requested protocols are incompatible with the protocol currently in use with the smart card.')

    # (0x80100010) The reader or smart card is not ready to accept commands.
    SCARD_E_NOT_READY = HResultCode.new('SCARD_E_NOT_READY', 0x80100010, 'The reader or smart card is not ready to accept commands.')

    # (0x80100011) One or more of the supplied parameters values could not be properly interpreted.
    SCARD_E_INVALID_VALUE = HResultCode.new('SCARD_E_INVALID_VALUE', 0x80100011, 'One or more of the supplied parameters values could not be properly interpreted.')

    # (0x80100012) The action was canceled by the system, presumably to log off or shut down.
    SCARD_E_SYSTEM_CANCELLED = HResultCode.new('SCARD_E_SYSTEM_CANCELLED', 0x80100012, 'The action was canceled by the system, presumably to log off or shut down.')

    # (0x80100013) An internal communications error has been detected.
    SCARD_F_COMM_ERROR = HResultCode.new('SCARD_F_COMM_ERROR', 0x80100013, 'An internal communications error has been detected.')

    # (0x80100014) An internal error has been detected, but the source is unknown.
    SCARD_F_UNKNOWN_ERROR = HResultCode.new('SCARD_F_UNKNOWN_ERROR', 0x80100014, 'An internal error has been detected, but the source is unknown.')

    # (0x80100015) An automatic terminal recognition (ATR) obtained from the registry is not a valid ATR string.
    SCARD_E_INVALID_ATR = HResultCode.new('SCARD_E_INVALID_ATR', 0x80100015, 'An automatic terminal recognition (ATR) obtained from the registry is not a valid ATR string.')

    # (0x80100016) An attempt was made to end a nonexistent transaction.
    SCARD_E_NOT_TRANSACTED = HResultCode.new('SCARD_E_NOT_TRANSACTED', 0x80100016, 'An attempt was made to end a nonexistent transaction.')

    # (0x80100017) The specified reader is not currently available for use.
    SCARD_E_READER_UNAVAILABLE = HResultCode.new('SCARD_E_READER_UNAVAILABLE', 0x80100017, 'The specified reader is not currently available for use.')

    # (0x80100018) The operation has been aborted to allow the server application to exit.
    SCARD_P_SHUTDOWN = HResultCode.new('SCARD_P_SHUTDOWN', 0x80100018, 'The operation has been aborted to allow the server application to exit.')

    # (0x80100019) The peripheral component interconnect (PCI) Receive buffer was too small.
    SCARD_E_PCI_TOO_SMALL = HResultCode.new('SCARD_E_PCI_TOO_SMALL', 0x80100019, 'The peripheral component interconnect (PCI) Receive buffer was too small.')

    # (0x8010001a) The reader driver does not meet minimal requirements for support.
    SCARD_E_READER_UNSUPPORTED = HResultCode.new('SCARD_E_READER_UNSUPPORTED', 0x8010001a, 'The reader driver does not meet minimal requirements for support.')

    # (0x8010001b) The reader driver did not produce a unique reader name.
    SCARD_E_DUPLICATE_READER = HResultCode.new('SCARD_E_DUPLICATE_READER', 0x8010001b, 'The reader driver did not produce a unique reader name.')

    # (0x8010001c) The smart card does not meet minimal requirements for support.
    SCARD_E_CARD_UNSUPPORTED = HResultCode.new('SCARD_E_CARD_UNSUPPORTED', 0x8010001c, 'The smart card does not meet minimal requirements for support.')

    # (0x8010001d) The smart card resource manager is not running.
    SCARD_E_NO_SERVICE = HResultCode.new('SCARD_E_NO_SERVICE', 0x8010001d, 'The smart card resource manager is not running.')

    # (0x8010001e) The smart card resource manager has shut down.
    SCARD_E_SERVICE_STOPPED = HResultCode.new('SCARD_E_SERVICE_STOPPED', 0x8010001e, 'The smart card resource manager has shut down.')

    # (0x8010001f) An unexpected card error has occurred.
    SCARD_E_UNEXPECTED = HResultCode.new('SCARD_E_UNEXPECTED', 0x8010001f, 'An unexpected card error has occurred.')

    # (0x80100020) No primary provider can be found for the smart card.
    SCARD_E_ICC_INSTALLATION = HResultCode.new('SCARD_E_ICC_INSTALLATION', 0x80100020, 'No primary provider can be found for the smart card.')

    # (0x80100021) The requested order of object creation is not supported.
    SCARD_E_ICC_CREATEORDER = HResultCode.new('SCARD_E_ICC_CREATEORDER', 0x80100021, 'The requested order of object creation is not supported.')

    # (0x80100022) This smart card does not support the requested feature.
    SCARD_E_UNSUPPORTED_FEATURE = HResultCode.new('SCARD_E_UNSUPPORTED_FEATURE', 0x80100022, 'This smart card does not support the requested feature.')

    # (0x80100023) The identified directory does not exist in the smart card.
    SCARD_E_DIR_NOT_FOUND = HResultCode.new('SCARD_E_DIR_NOT_FOUND', 0x80100023, 'The identified directory does not exist in the smart card.')

    # (0x80100024) The identified file does not exist in the smart card.
    SCARD_E_FILE_NOT_FOUND = HResultCode.new('SCARD_E_FILE_NOT_FOUND', 0x80100024, 'The identified file does not exist in the smart card.')

    # (0x80100025) The supplied path does not represent a smart card directory.
    SCARD_E_NO_DIR = HResultCode.new('SCARD_E_NO_DIR', 0x80100025, 'The supplied path does not represent a smart card directory.')

    # (0x80100026) The supplied path does not represent a smart card file.
    SCARD_E_NO_FILE = HResultCode.new('SCARD_E_NO_FILE', 0x80100026, 'The supplied path does not represent a smart card file.')

    # (0x80100027) Access is denied to this file.
    SCARD_E_NO_ACCESS = HResultCode.new('SCARD_E_NO_ACCESS', 0x80100027, 'Access is denied to this file.')

    # (0x80100028) The smart card does not have enough memory to store the information.
    SCARD_E_WRITE_TOO_MANY = HResultCode.new('SCARD_E_WRITE_TOO_MANY', 0x80100028, 'The smart card does not have enough memory to store the information.')

    # (0x80100029) There was an error trying to set the smart card file object pointer.
    SCARD_E_BAD_SEEK = HResultCode.new('SCARD_E_BAD_SEEK', 0x80100029, 'There was an error trying to set the smart card file object pointer.')

    # (0x8010002a) The supplied PIN is incorrect.
    SCARD_E_INVALID_CHV = HResultCode.new('SCARD_E_INVALID_CHV', 0x8010002a, 'The supplied PIN is incorrect.')

    # (0x8010002b) An unrecognized error code was returned from a layered component.
    SCARD_E_UNKNOWN_RES_MNG = HResultCode.new('SCARD_E_UNKNOWN_RES_MNG', 0x8010002b, 'An unrecognized error code was returned from a layered component.')

    # (0x8010002c) The requested certificate does not exist.
    SCARD_E_NO_SUCH_CERTIFICATE = HResultCode.new('SCARD_E_NO_SUCH_CERTIFICATE', 0x8010002c, 'The requested certificate does not exist.')

    # (0x8010002d) The requested certificate could not be obtained.
    SCARD_E_CERTIFICATE_UNAVAILABLE = HResultCode.new('SCARD_E_CERTIFICATE_UNAVAILABLE', 0x8010002d, 'The requested certificate could not be obtained.')

    # (0x8010002e) Cannot find a smart card reader.
    SCARD_E_NO_READERS_AVAILABLE = HResultCode.new('SCARD_E_NO_READERS_AVAILABLE', 0x8010002e, 'Cannot find a smart card reader.')

    # (0x8010002f) A communications error with the smart card has been detected. Retry the operation.
    SCARD_E_COMM_DATA_LOST = HResultCode.new('SCARD_E_COMM_DATA_LOST', 0x8010002f, 'A communications error with the smart card has been detected. Retry the operation.')

    # (0x80100030) The requested key container does not exist on the smart card.
    SCARD_E_NO_KEY_CONTAINER = HResultCode.new('SCARD_E_NO_KEY_CONTAINER', 0x80100030, 'The requested key container does not exist on the smart card.')

    # (0x80100031) The smart card resource manager is too busy to complete this operation.
    SCARD_E_SERVER_TOO_BUSY = HResultCode.new('SCARD_E_SERVER_TOO_BUSY', 0x80100031, 'The smart card resource manager is too busy to complete this operation.')

    # (0x80100065) The reader cannot communicate with the smart card, due to ATR configuration conflicts.
    SCARD_W_UNSUPPORTED_CARD = HResultCode.new('SCARD_W_UNSUPPORTED_CARD', 0x80100065, 'The reader cannot communicate with the smart card, due to ATR configuration conflicts.')

    # (0x80100066) The smart card is not responding to a reset.
    SCARD_W_UNRESPONSIVE_CARD = HResultCode.new('SCARD_W_UNRESPONSIVE_CARD', 0x80100066, 'The smart card is not responding to a reset.')

    # (0x80100067) Power has been removed from the smart card, so that further communication is not possible.
    SCARD_W_UNPOWERED_CARD = HResultCode.new('SCARD_W_UNPOWERED_CARD', 0x80100067, 'Power has been removed from the smart card, so that further communication is not possible.')

    # (0x80100068) The smart card has been reset, so any shared state information is invalid.
    SCARD_W_RESET_CARD = HResultCode.new('SCARD_W_RESET_CARD', 0x80100068, 'The smart card has been reset, so any shared state information is invalid.')

    # (0x80100069) The smart card has been removed, so that further communication is not possible.
    SCARD_W_REMOVED_CARD = HResultCode.new('SCARD_W_REMOVED_CARD', 0x80100069, 'The smart card has been removed, so that further communication is not possible.')

    # (0x8010006a) Access was denied because of a security violation.
    SCARD_W_SECURITY_VIOLATION = HResultCode.new('SCARD_W_SECURITY_VIOLATION', 0x8010006a, 'Access was denied because of a security violation.')

    # (0x8010006b) The card cannot be accessed because the wrong PIN was presented.
    SCARD_W_WRONG_CHV = HResultCode.new('SCARD_W_WRONG_CHV', 0x8010006b, 'The card cannot be accessed because the wrong PIN was presented.')

    # (0x8010006c) The card cannot be accessed because the maximum number of PIN entry attempts has been reached.
    SCARD_W_CHV_BLOCKED = HResultCode.new('SCARD_W_CHV_BLOCKED', 0x8010006c, 'The card cannot be accessed because the maximum number of PIN entry attempts has been reached.')

    # (0x8010006d) The end of the smart card file has been reached.
    SCARD_W_EOF = HResultCode.new('SCARD_W_EOF', 0x8010006d, 'The end of the smart card file has been reached.')

    # (0x8010006e) The action was canceled by the user.
    SCARD_W_CANCELLED_BY_USER = HResultCode.new('SCARD_W_CANCELLED_BY_USER', 0x8010006e, 'The action was canceled by the user.')

    # (0x8010006f) No PIN was presented to the smart card.
    SCARD_W_CARD_NOT_AUTHENTICATED = HResultCode.new('SCARD_W_CARD_NOT_AUTHENTICATED', 0x8010006f, 'No PIN was presented to the smart card.')

    # (0x80110401) Errors occurred accessing one or more objects—the ErrorInfo collection contains more detail.
    COMADMIN_E_OBJECTERRORS = HResultCode.new('COMADMIN_E_OBJECTERRORS', 0x80110401, 'Errors occurred accessing one or more objects—the ErrorInfo collection contains more detail.')

    # (0x80110402) One or more of the object's properties are missing or invalid.
    COMADMIN_E_OBJECTINVALID = HResultCode.new('COMADMIN_E_OBJECTINVALID', 0x80110402, 'One or more of the object\'s properties are missing or invalid.')

    # (0x80110403) The object was not found in the catalog.
    COMADMIN_E_KEYMISSING = HResultCode.new('COMADMIN_E_KEYMISSING', 0x80110403, 'The object was not found in the catalog.')

    # (0x80110404) The object is already registered.
    COMADMIN_E_ALREADYINSTALLED = HResultCode.new('COMADMIN_E_ALREADYINSTALLED', 0x80110404, 'The object is already registered.')

    # (0x80110407) An error occurred writing to the application file.
    COMADMIN_E_APP_FILE_WRITEFAIL = HResultCode.new('COMADMIN_E_APP_FILE_WRITEFAIL', 0x80110407, 'An error occurred writing to the application file.')

    # (0x80110408) An error occurred reading the application file.
    COMADMIN_E_APP_FILE_READFAIL = HResultCode.new('COMADMIN_E_APP_FILE_READFAIL', 0x80110408, 'An error occurred reading the application file.')

    # (0x80110409) Invalid version number in application file.
    COMADMIN_E_APP_FILE_VERSION = HResultCode.new('COMADMIN_E_APP_FILE_VERSION', 0x80110409, 'Invalid version number in application file.')

    # (0x8011040a) The file path is invalid.
    COMADMIN_E_BADPATH = HResultCode.new('COMADMIN_E_BADPATH', 0x8011040a, 'The file path is invalid.')

    # (0x8011040b) The application is already installed.
    COMADMIN_E_APPLICATIONEXISTS = HResultCode.new('COMADMIN_E_APPLICATIONEXISTS', 0x8011040b, 'The application is already installed.')

    # (0x8011040c) The role already exists.
    COMADMIN_E_ROLEEXISTS = HResultCode.new('COMADMIN_E_ROLEEXISTS', 0x8011040c, 'The role already exists.')

    # (0x8011040d) An error occurred copying the file.
    COMADMIN_E_CANTCOPYFILE = HResultCode.new('COMADMIN_E_CANTCOPYFILE', 0x8011040d, 'An error occurred copying the file.')

    # (0x8011040f) One or more users are not valid.
    COMADMIN_E_NOUSER = HResultCode.new('COMADMIN_E_NOUSER', 0x8011040f, 'One or more users are not valid.')

    # (0x80110410) One or more users in the application file are not valid.
    COMADMIN_E_INVALIDUSERIDS = HResultCode.new('COMADMIN_E_INVALIDUSERIDS', 0x80110410, 'One or more users in the application file are not valid.')

    # (0x80110411) The component's CLSID is missing or corrupt.
    COMADMIN_E_NOREGISTRYCLSID = HResultCode.new('COMADMIN_E_NOREGISTRYCLSID', 0x80110411, 'The component\'s CLSID is missing or corrupt.')

    # (0x80110412) The component's programmatic ID is missing or corrupt.
    COMADMIN_E_BADREGISTRYPROGID = HResultCode.new('COMADMIN_E_BADREGISTRYPROGID', 0x80110412, 'The component\'s programmatic ID is missing or corrupt.')

    # (0x80110413) Unable to set required authentication level for update request.
    COMADMIN_E_AUTHENTICATIONLEVEL = HResultCode.new('COMADMIN_E_AUTHENTICATIONLEVEL', 0x80110413, 'Unable to set required authentication level for update request.')

    # (0x80110414) The identity or password set on the application is not valid.
    COMADMIN_E_USERPASSWDNOTVALID = HResultCode.new('COMADMIN_E_USERPASSWDNOTVALID', 0x80110414, 'The identity or password set on the application is not valid.')

    # (0x80110418) Application file CLSIDs or instance identifiers (IIDs) do not match corresponding DLLs.
    COMADMIN_E_CLSIDORIIDMISMATCH = HResultCode.new('COMADMIN_E_CLSIDORIIDMISMATCH', 0x80110418, 'Application file CLSIDs or instance identifiers (IIDs) do not match corresponding DLLs.')

    # (0x80110419) Interface information is either missing or changed.
    COMADMIN_E_REMOTEINTERFACE = HResultCode.new('COMADMIN_E_REMOTEINTERFACE', 0x80110419, 'Interface information is either missing or changed.')

    # (0x8011041a) DllRegisterServer failed on component install.
    COMADMIN_E_DLLREGISTERSERVER = HResultCode.new('COMADMIN_E_DLLREGISTERSERVER', 0x8011041a, 'DllRegisterServer failed on component install.')

    # (0x8011041b) No server file share available.
    COMADMIN_E_NOSERVERSHARE = HResultCode.new('COMADMIN_E_NOSERVERSHARE', 0x8011041b, 'No server file share available.')

    # (0x8011041d) DLL could not be loaded.
    COMADMIN_E_DLLLOADFAILED = HResultCode.new('COMADMIN_E_DLLLOADFAILED', 0x8011041d, 'DLL could not be loaded.')

    # (0x8011041e) The registered TypeLib ID is not valid.
    COMADMIN_E_BADREGISTRYLIBID = HResultCode.new('COMADMIN_E_BADREGISTRYLIBID', 0x8011041e, 'The registered TypeLib ID is not valid.')

    # (0x8011041f) Application install directory not found.
    COMADMIN_E_APPDIRNOTFOUND = HResultCode.new('COMADMIN_E_APPDIRNOTFOUND', 0x8011041f, 'Application install directory not found.')

    # (0x80110423) Errors occurred while in the component registrar.
    COMADMIN_E_REGISTRARFAILED = HResultCode.new('COMADMIN_E_REGISTRARFAILED', 0x80110423, 'Errors occurred while in the component registrar.')

    # (0x80110424) The file does not exist.
    COMADMIN_E_COMPFILE_DOESNOTEXIST = HResultCode.new('COMADMIN_E_COMPFILE_DOESNOTEXIST', 0x80110424, 'The file does not exist.')

    # (0x80110425) The DLL could not be loaded.
    COMADMIN_E_COMPFILE_LOADDLLFAIL = HResultCode.new('COMADMIN_E_COMPFILE_LOADDLLFAIL', 0x80110425, 'The DLL could not be loaded.')

    # (0x80110426) GetClassObject failed in the DLL.
    COMADMIN_E_COMPFILE_GETCLASSOBJ = HResultCode.new('COMADMIN_E_COMPFILE_GETCLASSOBJ', 0x80110426, 'GetClassObject failed in the DLL.')

    # (0x80110427) The DLL does not support the components listed in the TypeLib.
    COMADMIN_E_COMPFILE_CLASSNOTAVAIL = HResultCode.new('COMADMIN_E_COMPFILE_CLASSNOTAVAIL', 0x80110427, 'The DLL does not support the components listed in the TypeLib.')

    # (0x80110428) The TypeLib could not be loaded.
    COMADMIN_E_COMPFILE_BADTLB = HResultCode.new('COMADMIN_E_COMPFILE_BADTLB', 0x80110428, 'The TypeLib could not be loaded.')

    # (0x80110429) The file does not contain components or component information.
    COMADMIN_E_COMPFILE_NOTINSTALLABLE = HResultCode.new('COMADMIN_E_COMPFILE_NOTINSTALLABLE', 0x80110429, 'The file does not contain components or component information.')

    # (0x8011042a) Changes to this object and its subobjects have been disabled.
    COMADMIN_E_NOTCHANGEABLE = HResultCode.new('COMADMIN_E_NOTCHANGEABLE', 0x8011042a, 'Changes to this object and its subobjects have been disabled.')

    # (0x8011042b) The delete function has been disabled for this object.
    COMADMIN_E_NOTDELETEABLE = HResultCode.new('COMADMIN_E_NOTDELETEABLE', 0x8011042b, 'The delete function has been disabled for this object.')

    # (0x8011042c) The server catalog version is not supported.
    COMADMIN_E_SESSION = HResultCode.new('COMADMIN_E_SESSION', 0x8011042c, 'The server catalog version is not supported.')

    # (0x8011042d) The component move was disallowed because the source or destination application is either a system application or currently locked against changes.
    COMADMIN_E_COMP_MOVE_LOCKED = HResultCode.new('COMADMIN_E_COMP_MOVE_LOCKED', 0x8011042d, 'The component move was disallowed because the source or destination application is either a system application or currently locked against changes.')

    # (0x8011042e) The component move failed because the destination application no longer exists.
    COMADMIN_E_COMP_MOVE_BAD_DEST = HResultCode.new('COMADMIN_E_COMP_MOVE_BAD_DEST', 0x8011042e, 'The component move failed because the destination application no longer exists.')

    # (0x80110430) The system was unable to register the TypeLib.
    COMADMIN_E_REGISTERTLB = HResultCode.new('COMADMIN_E_REGISTERTLB', 0x80110430, 'The system was unable to register the TypeLib.')

    # (0x80110433) This operation cannot be performed on the system application.
    COMADMIN_E_SYSTEMAPP = HResultCode.new('COMADMIN_E_SYSTEMAPP', 0x80110433, 'This operation cannot be performed on the system application.')

    # (0x80110434) The component registrar referenced in this file is not available.
    COMADMIN_E_COMPFILE_NOREGISTRAR = HResultCode.new('COMADMIN_E_COMPFILE_NOREGISTRAR', 0x80110434, 'The component registrar referenced in this file is not available.')

    # (0x80110435) A component in the same DLL is already installed.
    COMADMIN_E_COREQCOMPINSTALLED = HResultCode.new('COMADMIN_E_COREQCOMPINSTALLED', 0x80110435, 'A component in the same DLL is already installed.')

    # (0x80110436) The service is not installed.
    COMADMIN_E_SERVICENOTINSTALLED = HResultCode.new('COMADMIN_E_SERVICENOTINSTALLED', 0x80110436, 'The service is not installed.')

    # (0x80110437) One or more property settings are either invalid or in conflict with each other.
    COMADMIN_E_PROPERTYSAVEFAILED = HResultCode.new('COMADMIN_E_PROPERTYSAVEFAILED', 0x80110437, 'One or more property settings are either invalid or in conflict with each other.')

    # (0x80110438) The object you are attempting to add or rename already exists.
    COMADMIN_E_OBJECTEXISTS = HResultCode.new('COMADMIN_E_OBJECTEXISTS', 0x80110438, 'The object you are attempting to add or rename already exists.')

    # (0x80110439) The component already exists.
    COMADMIN_E_COMPONENTEXISTS = HResultCode.new('COMADMIN_E_COMPONENTEXISTS', 0x80110439, 'The component already exists.')

    # (0x8011043b) The registration file is corrupt.
    COMADMIN_E_REGFILE_CORRUPT = HResultCode.new('COMADMIN_E_REGFILE_CORRUPT', 0x8011043b, 'The registration file is corrupt.')

    # (0x8011043c) The property value is too large.
    COMADMIN_E_PROPERTY_OVERFLOW = HResultCode.new('COMADMIN_E_PROPERTY_OVERFLOW', 0x8011043c, 'The property value is too large.')

    # (0x8011043e) Object was not found in registry.
    COMADMIN_E_NOTINREGISTRY = HResultCode.new('COMADMIN_E_NOTINREGISTRY', 0x8011043e, 'Object was not found in registry.')

    # (0x8011043f) This object cannot be pooled.
    COMADMIN_E_OBJECTNOTPOOLABLE = HResultCode.new('COMADMIN_E_OBJECTNOTPOOLABLE', 0x8011043f, 'This object cannot be pooled.')

    # (0x80110446) A CLSID with the same GUID as the new application ID is already installed on this machine.
    COMADMIN_E_APPLID_MATCHES_CLSID = HResultCode.new('COMADMIN_E_APPLID_MATCHES_CLSID', 0x80110446, 'A CLSID with the same GUID as the new application ID is already installed on this machine.')

    # (0x80110447) A role assigned to a component, interface, or method did not exist in the application.
    COMADMIN_E_ROLE_DOES_NOT_EXIST = HResultCode.new('COMADMIN_E_ROLE_DOES_NOT_EXIST', 0x80110447, 'A role assigned to a component, interface, or method did not exist in the application.')

    # (0x80110448) You must have components in an application to start the application.
    COMADMIN_E_START_APP_NEEDS_COMPONENTS = HResultCode.new('COMADMIN_E_START_APP_NEEDS_COMPONENTS', 0x80110448, 'You must have components in an application to start the application.')

    # (0x80110449) This operation is not enabled on this platform.
    COMADMIN_E_REQUIRES_DIFFERENT_PLATFORM = HResultCode.new('COMADMIN_E_REQUIRES_DIFFERENT_PLATFORM', 0x80110449, 'This operation is not enabled on this platform.')

    # (0x8011044a) Application proxy is not exportable.
    COMADMIN_E_CAN_NOT_EXPORT_APP_PROXY = HResultCode.new('COMADMIN_E_CAN_NOT_EXPORT_APP_PROXY', 0x8011044a, 'Application proxy is not exportable.')

    # (0x8011044b) Failed to start application because it is either a library application or an application proxy.
    COMADMIN_E_CAN_NOT_START_APP = HResultCode.new('COMADMIN_E_CAN_NOT_START_APP', 0x8011044b, 'Failed to start application because it is either a library application or an application proxy.')

    # (0x8011044c) System application is not exportable.
    COMADMIN_E_CAN_NOT_EXPORT_SYS_APP = HResultCode.new('COMADMIN_E_CAN_NOT_EXPORT_SYS_APP', 0x8011044c, 'System application is not exportable.')

    # (0x8011044d) Cannot subscribe to this component (the component might have been imported).
    COMADMIN_E_CANT_SUBSCRIBE_TO_COMPONENT = HResultCode.new('COMADMIN_E_CANT_SUBSCRIBE_TO_COMPONENT', 0x8011044d, 'Cannot subscribe to this component (the component might have been imported).')

    # (0x8011044e) An event class cannot also be a subscriber component.
    COMADMIN_E_EVENTCLASS_CANT_BE_SUBSCRIBER = HResultCode.new('COMADMIN_E_EVENTCLASS_CANT_BE_SUBSCRIBER', 0x8011044e, 'An event class cannot also be a subscriber component.')

    # (0x8011044f) Library applications and application proxies are incompatible.
    COMADMIN_E_LIB_APP_PROXY_INCOMPATIBLE = HResultCode.new('COMADMIN_E_LIB_APP_PROXY_INCOMPATIBLE', 0x8011044f, 'Library applications and application proxies are incompatible.')

    # (0x80110450) This function is valid for the base partition only.
    COMADMIN_E_BASE_PARTITION_ONLY = HResultCode.new('COMADMIN_E_BASE_PARTITION_ONLY', 0x80110450, 'This function is valid for the base partition only.')

    # (0x80110451) You cannot start an application that has been disabled.
    COMADMIN_E_START_APP_DISABLED = HResultCode.new('COMADMIN_E_START_APP_DISABLED', 0x80110451, 'You cannot start an application that has been disabled.')

    # (0x80110457) The specified partition name is already in use on this computer.
    COMADMIN_E_CAT_DUPLICATE_PARTITION_NAME = HResultCode.new('COMADMIN_E_CAT_DUPLICATE_PARTITION_NAME', 0x80110457, 'The specified partition name is already in use on this computer.')

    # (0x80110458) The specified partition name is invalid. Check that the name contains at least one visible character.
    COMADMIN_E_CAT_INVALID_PARTITION_NAME = HResultCode.new('COMADMIN_E_CAT_INVALID_PARTITION_NAME', 0x80110458, 'The specified partition name is invalid. Check that the name contains at least one visible character.')

    # (0x80110459) The partition cannot be deleted because it is the default partition for one or more users.
    COMADMIN_E_CAT_PARTITION_IN_USE = HResultCode.new('COMADMIN_E_CAT_PARTITION_IN_USE', 0x80110459, 'The partition cannot be deleted because it is the default partition for one or more users.')

    # (0x8011045a) The partition cannot be exported because one or more components in the partition have the same file name.
    COMADMIN_E_FILE_PARTITION_DUPLICATE_FILES = HResultCode.new('COMADMIN_E_FILE_PARTITION_DUPLICATE_FILES', 0x8011045a, 'The partition cannot be exported because one or more components in the partition have the same file name.')

    # (0x8011045b) Applications that contain one or more imported components cannot be installed into a nonbase partition.
    COMADMIN_E_CAT_IMPORTED_COMPONENTS_NOT_ALLOWED = HResultCode.new('COMADMIN_E_CAT_IMPORTED_COMPONENTS_NOT_ALLOWED', 0x8011045b, 'Applications that contain one or more imported components cannot be installed into a nonbase partition.')

    # (0x8011045c) The application name is not unique and cannot be resolved to an application ID.
    COMADMIN_E_AMBIGUOUS_APPLICATION_NAME = HResultCode.new('COMADMIN_E_AMBIGUOUS_APPLICATION_NAME', 0x8011045c, 'The application name is not unique and cannot be resolved to an application ID.')

    # (0x8011045d) The partition name is not unique and cannot be resolved to a partition ID.
    COMADMIN_E_AMBIGUOUS_PARTITION_NAME = HResultCode.new('COMADMIN_E_AMBIGUOUS_PARTITION_NAME', 0x8011045d, 'The partition name is not unique and cannot be resolved to a partition ID.')

    # (0x80110472) The COM+ registry database has not been initialized.
    COMADMIN_E_REGDB_NOTINITIALIZED = HResultCode.new('COMADMIN_E_REGDB_NOTINITIALIZED', 0x80110472, 'The COM+ registry database has not been initialized.')

    # (0x80110473) The COM+ registry database is not open.
    COMADMIN_E_REGDB_NOTOPEN = HResultCode.new('COMADMIN_E_REGDB_NOTOPEN', 0x80110473, 'The COM+ registry database is not open.')

    # (0x80110474) The COM+ registry database detected a system error.
    COMADMIN_E_REGDB_SYSTEMERR = HResultCode.new('COMADMIN_E_REGDB_SYSTEMERR', 0x80110474, 'The COM+ registry database detected a system error.')

    # (0x80110475) The COM+ registry database is already running.
    COMADMIN_E_REGDB_ALREADYRUNNING = HResultCode.new('COMADMIN_E_REGDB_ALREADYRUNNING', 0x80110475, 'The COM+ registry database is already running.')

    # (0x80110480) This version of the COM+ registry database cannot be migrated.
    COMADMIN_E_MIG_VERSIONNOTSUPPORTED = HResultCode.new('COMADMIN_E_MIG_VERSIONNOTSUPPORTED', 0x80110480, 'This version of the COM+ registry database cannot be migrated.')

    # (0x80110481) The schema version to be migrated could not be found in the COM+ registry database.
    COMADMIN_E_MIG_SCHEMANOTFOUND = HResultCode.new('COMADMIN_E_MIG_SCHEMANOTFOUND', 0x80110481, 'The schema version to be migrated could not be found in the COM+ registry database.')

    # (0x80110482) There was a type mismatch between binaries.
    COMADMIN_E_CAT_BITNESSMISMATCH = HResultCode.new('COMADMIN_E_CAT_BITNESSMISMATCH', 0x80110482, 'There was a type mismatch between binaries.')

    # (0x80110483) A binary of unknown or invalid type was provided.
    COMADMIN_E_CAT_UNACCEPTABLEBITNESS = HResultCode.new('COMADMIN_E_CAT_UNACCEPTABLEBITNESS', 0x80110483, 'A binary of unknown or invalid type was provided.')

    # (0x80110484) There was a type mismatch between a binary and an application.
    COMADMIN_E_CAT_WRONGAPPBITNESS = HResultCode.new('COMADMIN_E_CAT_WRONGAPPBITNESS', 0x80110484, 'There was a type mismatch between a binary and an application.')

    # (0x80110485) The application cannot be paused or resumed.
    COMADMIN_E_CAT_PAUSE_RESUME_NOT_SUPPORTED = HResultCode.new('COMADMIN_E_CAT_PAUSE_RESUME_NOT_SUPPORTED', 0x80110485, 'The application cannot be paused or resumed.')

    # (0x80110486) The COM+ catalog server threw an exception during execution.
    COMADMIN_E_CAT_SERVERFAULT = HResultCode.new('COMADMIN_E_CAT_SERVERFAULT', 0x80110486, 'The COM+ catalog server threw an exception during execution.')

    # (0x80110600) Only COM+ applications marked "queued" can be invoked using the "queue" moniker.
    COMQC_E_APPLICATION_NOT_QUEUED = HResultCode.new('COMQC_E_APPLICATION_NOT_QUEUED', 0x80110600, 'Only COM+ applications marked "queued" can be invoked using the "queue" moniker.')

    # (0x80110601) At least one interface must be marked "queued" to create a queued component instance with the "queue" moniker.
    COMQC_E_NO_QUEUEABLE_INTERFACES = HResultCode.new('COMQC_E_NO_QUEUEABLE_INTERFACES', 0x80110601, 'At least one interface must be marked "queued" to create a queued component instance with the "queue" moniker.')

    # (0x80110602) Message Queuing is required for the requested operation and is not installed.
    COMQC_E_QUEUING_SERVICE_NOT_AVAILABLE = HResultCode.new('COMQC_E_QUEUING_SERVICE_NOT_AVAILABLE', 0x80110602, 'Message Queuing is required for the requested operation and is not installed.')

    # (0x80110603) Unable to marshal an interface that does not support IPersistStream.
    COMQC_E_NO_IPERSISTSTREAM = HResultCode.new('COMQC_E_NO_IPERSISTSTREAM', 0x80110603, 'Unable to marshal an interface that does not support IPersistStream.')

    # (0x80110604) The message is improperly formatted or was damaged in transit.
    COMQC_E_BAD_MESSAGE = HResultCode.new('COMQC_E_BAD_MESSAGE', 0x80110604, 'The message is improperly formatted or was damaged in transit.')

    # (0x80110605) An unauthenticated message was received by an application that accepts only authenticated messages.
    COMQC_E_UNAUTHENTICATED = HResultCode.new('COMQC_E_UNAUTHENTICATED', 0x80110605, 'An unauthenticated message was received by an application that accepts only authenticated messages.')

    # (0x80110606) The message was requeued or moved by a user not in the QC Trusted User "role".
    COMQC_E_UNTRUSTED_ENQUEUER = HResultCode.new('COMQC_E_UNTRUSTED_ENQUEUER', 0x80110606, 'The message was requeued or moved by a user not in the QC Trusted User "role".')

    # (0x80110701) Cannot create a duplicate resource of type Distributed Transaction Coordinator.
    MSDTC_E_DUPLICATE_RESOURCE = HResultCode.new('MSDTC_E_DUPLICATE_RESOURCE', 0x80110701, 'Cannot create a duplicate resource of type Distributed Transaction Coordinator.')

    # (0x80110808) One of the objects being inserted or updated does not belong to a valid parent collection.
    COMADMIN_E_OBJECT_PARENT_MISSING = HResultCode.new('COMADMIN_E_OBJECT_PARENT_MISSING', 0x80110808, 'One of the objects being inserted or updated does not belong to a valid parent collection.')

    # (0x80110809) One of the specified objects cannot be found.
    COMADMIN_E_OBJECT_DOES_NOT_EXIST = HResultCode.new('COMADMIN_E_OBJECT_DOES_NOT_EXIST', 0x80110809, 'One of the specified objects cannot be found.')

    # (0x8011080a) The specified application is not currently running.
    COMADMIN_E_APP_NOT_RUNNING = HResultCode.new('COMADMIN_E_APP_NOT_RUNNING', 0x8011080a, 'The specified application is not currently running.')

    # (0x8011080b) The partitions specified are not valid.
    COMADMIN_E_INVALID_PARTITION = HResultCode.new('COMADMIN_E_INVALID_PARTITION', 0x8011080b, 'The partitions specified are not valid.')

    # (0x8011080d) COM+ applications that run as Windows NT service cannot be pooled or recycled.
    COMADMIN_E_SVCAPP_NOT_POOLABLE_OR_RECYCLABLE = HResultCode.new('COMADMIN_E_SVCAPP_NOT_POOLABLE_OR_RECYCLABLE', 0x8011080d, 'COM+ applications that run as Windows NT service cannot be pooled or recycled.')

    # (0x8011080e) One or more users are already assigned to a local partition set.
    COMADMIN_E_USER_IN_SET = HResultCode.new('COMADMIN_E_USER_IN_SET', 0x8011080e, 'One or more users are already assigned to a local partition set.')

    # (0x8011080f) Library applications cannot be recycled.
    COMADMIN_E_CANTRECYCLELIBRARYAPPS = HResultCode.new('COMADMIN_E_CANTRECYCLELIBRARYAPPS', 0x8011080f, 'Library applications cannot be recycled.')

    # (0x80110811) Applications running as Windows NT services cannot be recycled.
    COMADMIN_E_CANTRECYCLESERVICEAPPS = HResultCode.new('COMADMIN_E_CANTRECYCLESERVICEAPPS', 0x80110811, 'Applications running as Windows NT services cannot be recycled.')

    # (0x80110812) The process has already been recycled.
    COMADMIN_E_PROCESSALREADYRECYCLED = HResultCode.new('COMADMIN_E_PROCESSALREADYRECYCLED', 0x80110812, 'The process has already been recycled.')

    # (0x80110813) A paused process cannot be recycled.
    COMADMIN_E_PAUSEDPROCESSMAYNOTBERECYCLED = HResultCode.new('COMADMIN_E_PAUSEDPROCESSMAYNOTBERECYCLED', 0x80110813, 'A paused process cannot be recycled.')

    # (0x80110814) Library applications cannot be Windows NT services.
    COMADMIN_E_CANTMAKEINPROCSERVICE = HResultCode.new('COMADMIN_E_CANTMAKEINPROCSERVICE', 0x80110814, 'Library applications cannot be Windows NT services.')

    # (0x80110815) The ProgID provided to the copy operation is invalid. The ProgID is in use by another registered CLSID.
    COMADMIN_E_PROGIDINUSEBYCLSID = HResultCode.new('COMADMIN_E_PROGIDINUSEBYCLSID', 0x80110815, 'The ProgID provided to the copy operation is invalid. The ProgID is in use by another registered CLSID.')

    # (0x80110816) The partition specified as the default is not a member of the partition set.
    COMADMIN_E_DEFAULT_PARTITION_NOT_IN_SET = HResultCode.new('COMADMIN_E_DEFAULT_PARTITION_NOT_IN_SET', 0x80110816, 'The partition specified as the default is not a member of the partition set.')

    # (0x80110817) A recycled process cannot be paused.
    COMADMIN_E_RECYCLEDPROCESSMAYNOTBEPAUSED = HResultCode.new('COMADMIN_E_RECYCLEDPROCESSMAYNOTBEPAUSED', 0x80110817, 'A recycled process cannot be paused.')

    # (0x80110818) Access to the specified partition is denied.
    COMADMIN_E_PARTITION_ACCESSDENIED = HResultCode.new('COMADMIN_E_PARTITION_ACCESSDENIED', 0x80110818, 'Access to the specified partition is denied.')

    # (0x80110819) Only application files (*.msi files) can be installed into partitions.
    COMADMIN_E_PARTITION_MSI_ONLY = HResultCode.new('COMADMIN_E_PARTITION_MSI_ONLY', 0x80110819, 'Only application files (*.msi files) can be installed into partitions.')

    # (0x8011081a) Applications containing one or more legacy components cannot be exported to 1.0 format.
    COMADMIN_E_LEGACYCOMPS_NOT_ALLOWED_IN_1_0_FORMAT = HResultCode.new('COMADMIN_E_LEGACYCOMPS_NOT_ALLOWED_IN_1_0_FORMAT', 0x8011081a, 'Applications containing one or more legacy components cannot be exported to 1.0 format.')

    # (0x8011081b) Legacy components cannot exist in nonbase partitions.
    COMADMIN_E_LEGACYCOMPS_NOT_ALLOWED_IN_NONBASE_PARTITIONS = HResultCode.new('COMADMIN_E_LEGACYCOMPS_NOT_ALLOWED_IN_NONBASE_PARTITIONS', 0x8011081b, 'Legacy components cannot exist in nonbase partitions.')

    # (0x8011081c) A component cannot be moved (or copied) from the System Application, an application proxy, or a nonchangeable application.
    COMADMIN_E_COMP_MOVE_SOURCE = HResultCode.new('COMADMIN_E_COMP_MOVE_SOURCE', 0x8011081c, 'A component cannot be moved (or copied) from the System Application, an application proxy, or a nonchangeable application.')

    # (0x8011081d) A component cannot be moved (or copied) to the System Application, an application proxy or a nonchangeable application.
    COMADMIN_E_COMP_MOVE_DEST = HResultCode.new('COMADMIN_E_COMP_MOVE_DEST', 0x8011081d, 'A component cannot be moved (or copied) to the System Application, an application proxy or a nonchangeable application.')

    # (0x8011081e) A private component cannot be moved (or copied) to a library application or to the base partition.
    COMADMIN_E_COMP_MOVE_PRIVATE = HResultCode.new('COMADMIN_E_COMP_MOVE_PRIVATE', 0x8011081e, 'A private component cannot be moved (or copied) to a library application or to the base partition.')

    # (0x8011081f) The Base Application Partition exists in all partition sets and cannot be removed.
    COMADMIN_E_BASEPARTITION_REQUIRED_IN_SET = HResultCode.new('COMADMIN_E_BASEPARTITION_REQUIRED_IN_SET', 0x8011081f, 'The Base Application Partition exists in all partition sets and cannot be removed.')

    # (0x80110820) Alas, Event Class components cannot be aliased.
    COMADMIN_E_CANNOT_ALIAS_EVENTCLASS = HResultCode.new('COMADMIN_E_CANNOT_ALIAS_EVENTCLASS', 0x80110820, 'Alas, Event Class components cannot be aliased.')

    # (0x80110821) Access is denied because the component is private.
    COMADMIN_E_PRIVATE_ACCESSDENIED = HResultCode.new('COMADMIN_E_PRIVATE_ACCESSDENIED', 0x80110821, 'Access is denied because the component is private.')

    # (0x80110822) The specified SAFER level is invalid.
    COMADMIN_E_SAFERINVALID = HResultCode.new('COMADMIN_E_SAFERINVALID', 0x80110822, 'The specified SAFER level is invalid.')

    # (0x80110823) The specified user cannot write to the system registry.
    COMADMIN_E_REGISTRY_ACCESSDENIED = HResultCode.new('COMADMIN_E_REGISTRY_ACCESSDENIED', 0x80110823, 'The specified user cannot write to the system registry.')

    # (0x80110824) COM+ partitions are currently disabled.
    COMADMIN_E_PARTITIONS_DISABLED = HResultCode.new('COMADMIN_E_PARTITIONS_DISABLED', 0x80110824, 'COM+ partitions are currently disabled.')

    # (0x801f0001) A handler was not defined by the filter for this operation.
    ERROR_FLT_NO_HANDLER_DEFINED = HResultCode.new('ERROR_FLT_NO_HANDLER_DEFINED', 0x801f0001, 'A handler was not defined by the filter for this operation.')

    # (0x801f0002) A context is already defined for this object.
    ERROR_FLT_CONTEXT_ALREADY_DEFINED = HResultCode.new('ERROR_FLT_CONTEXT_ALREADY_DEFINED', 0x801f0002, 'A context is already defined for this object.')

    # (0x801f0003) Asynchronous requests are not valid for this operation.
    ERROR_FLT_INVALID_ASYNCHRONOUS_REQUEST = HResultCode.new('ERROR_FLT_INVALID_ASYNCHRONOUS_REQUEST', 0x801f0003, 'Asynchronous requests are not valid for this operation.')

    # (0x801f0004) Disallow the Fast IO path for this operation.
    ERROR_FLT_DISALLOW_FAST_IO = HResultCode.new('ERROR_FLT_DISALLOW_FAST_IO', 0x801f0004, 'Disallow the Fast IO path for this operation.')

    # (0x801f0005) An invalid name request was made. The name requested cannot be retrieved at this time.
    ERROR_FLT_INVALID_NAME_REQUEST = HResultCode.new('ERROR_FLT_INVALID_NAME_REQUEST', 0x801f0005, 'An invalid name request was made. The name requested cannot be retrieved at this time.')

    # (0x801f0006) Posting this operation to a worker thread for further processing is not safe at this time because it could lead to a system deadlock.
    ERROR_FLT_NOT_SAFE_TO_POST_OPERATION = HResultCode.new('ERROR_FLT_NOT_SAFE_TO_POST_OPERATION', 0x801f0006, 'Posting this operation to a worker thread for further processing is not safe at this time because it could lead to a system deadlock.')

    # (0x801f0007) The Filter Manager was not initialized when a filter tried to register. Be sure that the Filter Manager is being loaded as a driver.
    ERROR_FLT_NOT_INITIALIZED = HResultCode.new('ERROR_FLT_NOT_INITIALIZED', 0x801f0007, 'The Filter Manager was not initialized when a filter tried to register. Be sure that the Filter Manager is being loaded as a driver.')

    # (0x801f0008) The filter is not ready for attachment to volumes because it has not finished initializing (FltStartFiltering has not been called).
    ERROR_FLT_FILTER_NOT_READY = HResultCode.new('ERROR_FLT_FILTER_NOT_READY', 0x801f0008, 'The filter is not ready for attachment to volumes because it has not finished initializing (FltStartFiltering has not been called).')

    # (0x801f0009) The filter must clean up any operation-specific context at this time because it is being removed from the system before the operation is completed by the lower drivers.
    ERROR_FLT_POST_OPERATION_CLEANUP = HResultCode.new('ERROR_FLT_POST_OPERATION_CLEANUP', 0x801f0009, 'The filter must clean up any operation-specific context at this time because it is being removed from the system before the operation is completed by the lower drivers.')

    # (0x801f000a) The Filter Manager had an internal error from which it cannot recover; therefore, the operation has been failed. This is usually the result of a filter returning an invalid value from a preoperation callback.
    ERROR_FLT_INTERNAL_ERROR = HResultCode.new('ERROR_FLT_INTERNAL_ERROR', 0x801f000a, 'The Filter Manager had an internal error from which it cannot recover; therefore, the operation has been failed. This is usually the result of a filter returning an invalid value from a preoperation callback.')

    # (0x801f000b) The object specified for this action is in the process of being deleted; therefore, the action requested cannot be completed at this time.
    ERROR_FLT_DELETING_OBJECT = HResultCode.new('ERROR_FLT_DELETING_OBJECT', 0x801f000b, 'The object specified for this action is in the process of being deleted; therefore, the action requested cannot be completed at this time.')

    # (0x801f000c) Nonpaged pool must be used for this type of context.
    ERROR_FLT_MUST_BE_NONPAGED_POOL = HResultCode.new('ERROR_FLT_MUST_BE_NONPAGED_POOL', 0x801f000c, 'Nonpaged pool must be used for this type of context.')

    # (0x801f000d) A duplicate handler definition has been provided for an operation.
    ERROR_FLT_DUPLICATE_ENTRY = HResultCode.new('ERROR_FLT_DUPLICATE_ENTRY', 0x801f000d, 'A duplicate handler definition has been provided for an operation.')

    # (0x801f000e) The callback data queue has been disabled.
    ERROR_FLT_CBDQ_DISABLED = HResultCode.new('ERROR_FLT_CBDQ_DISABLED', 0x801f000e, 'The callback data queue has been disabled.')

    # (0x801f000f) Do not attach the filter to the volume at this time.
    ERROR_FLT_DO_NOT_ATTACH = HResultCode.new('ERROR_FLT_DO_NOT_ATTACH', 0x801f000f, 'Do not attach the filter to the volume at this time.')

    # (0x801f0010) Do not detach the filter from the volume at this time.
    ERROR_FLT_DO_NOT_DETACH = HResultCode.new('ERROR_FLT_DO_NOT_DETACH', 0x801f0010, 'Do not detach the filter from the volume at this time.')

    # (0x801f0011) An instance already exists at this altitude on the volume specified.
    ERROR_FLT_INSTANCE_ALTITUDE_COLLISION = HResultCode.new('ERROR_FLT_INSTANCE_ALTITUDE_COLLISION', 0x801f0011, 'An instance already exists at this altitude on the volume specified.')

    # (0x801f0012) An instance already exists with this name on the volume specified.
    ERROR_FLT_INSTANCE_NAME_COLLISION = HResultCode.new('ERROR_FLT_INSTANCE_NAME_COLLISION', 0x801f0012, 'An instance already exists with this name on the volume specified.')

    # (0x801f0013) The system could not find the filter specified.
    ERROR_FLT_FILTER_NOT_FOUND = HResultCode.new('ERROR_FLT_FILTER_NOT_FOUND', 0x801f0013, 'The system could not find the filter specified.')

    # (0x801f0014) The system could not find the volume specified.
    ERROR_FLT_VOLUME_NOT_FOUND = HResultCode.new('ERROR_FLT_VOLUME_NOT_FOUND', 0x801f0014, 'The system could not find the volume specified.')

    # (0x801f0015) The system could not find the instance specified.
    ERROR_FLT_INSTANCE_NOT_FOUND = HResultCode.new('ERROR_FLT_INSTANCE_NOT_FOUND', 0x801f0015, 'The system could not find the instance specified.')

    # (0x801f0016) No registered context allocation definition was found for the given request.
    ERROR_FLT_CONTEXT_ALLOCATION_NOT_FOUND = HResultCode.new('ERROR_FLT_CONTEXT_ALLOCATION_NOT_FOUND', 0x801f0016, 'No registered context allocation definition was found for the given request.')

    # (0x801f0017) An invalid parameter was specified during context registration.
    ERROR_FLT_INVALID_CONTEXT_REGISTRATION = HResultCode.new('ERROR_FLT_INVALID_CONTEXT_REGISTRATION', 0x801f0017, 'An invalid parameter was specified during context registration.')

    # (0x801f0018) The name requested was not found in the Filter Manager name cache and could not be retrieved from the file system.
    ERROR_FLT_NAME_CACHE_MISS = HResultCode.new('ERROR_FLT_NAME_CACHE_MISS', 0x801f0018, 'The name requested was not found in the Filter Manager name cache and could not be retrieved from the file system.')

    # (0x801f0019) The requested device object does not exist for the given volume.
    ERROR_FLT_NO_DEVICE_OBJECT = HResultCode.new('ERROR_FLT_NO_DEVICE_OBJECT', 0x801f0019, 'The requested device object does not exist for the given volume.')

    # (0x801f001a) The specified volume is already mounted.
    ERROR_FLT_VOLUME_ALREADY_MOUNTED = HResultCode.new('ERROR_FLT_VOLUME_ALREADY_MOUNTED', 0x801f001a, 'The specified volume is already mounted.')

    # (0x801f001b) The specified Transaction Context is already enlisted in a transaction.
    ERROR_FLT_ALREADY_ENLISTED = HResultCode.new('ERROR_FLT_ALREADY_ENLISTED', 0x801f001b, 'The specified Transaction Context is already enlisted in a transaction.')

    # (0x801f001c) The specified context is already attached to another object.
    ERROR_FLT_CONTEXT_ALREADY_LINKED = HResultCode.new('ERROR_FLT_CONTEXT_ALREADY_LINKED', 0x801f001c, 'The specified context is already attached to another object.')

    # (0x801f0020) No waiter is present for the filter's reply to this message.
    ERROR_FLT_NO_WAITER_FOR_REPLY = HResultCode.new('ERROR_FLT_NO_WAITER_FOR_REPLY', 0x801f0020, 'No waiter is present for the filter\'s reply to this message.')

    # (0x80260001) {Display Driver Stopped Responding} The %hs display driver has stopped working normally. Save your work and reboot the system to restore full display functionality. The next time you reboot the machine a dialog will be displayed giving you a chance to report this failure to Microsoft.
    ERROR_HUNG_DISPLAY_DRIVER_THREAD = HResultCode.new('ERROR_HUNG_DISPLAY_DRIVER_THREAD', 0x80260001, '{Display Driver Stopped Responding} The %hs display driver has stopped working normally. Save your work and reboot the system to restore full display functionality. The next time you reboot the machine a dialog will be displayed giving you a chance to report this failure to Microsoft.')

    # (0x80261001) Monitor descriptor could not be obtained.
    ERROR_MONITOR_NO_DESCRIPTOR = HResultCode.new('ERROR_MONITOR_NO_DESCRIPTOR', 0x80261001, 'Monitor descriptor could not be obtained.')

    # (0x80261002) Format of the obtained monitor descriptor is not supported by this release.
    ERROR_MONITOR_UNKNOWN_DESCRIPTOR_FORMAT = HResultCode.new('ERROR_MONITOR_UNKNOWN_DESCRIPTOR_FORMAT', 0x80261002, 'Format of the obtained monitor descriptor is not supported by this release.')

    # (0x80263001) {Desktop Composition is Disabled} The operation could not be completed because desktop composition is disabled.
    DWM_E_COMPOSITIONDISABLED = HResultCode.new('DWM_E_COMPOSITIONDISABLED', 0x80263001, '{Desktop Composition is Disabled} The operation could not be completed because desktop composition is disabled.')

    # (0x80263002) {Some Desktop Composition APIs Are Not Supported While Remoting} Some desktop composition APIs are not supported while remoting. The operation is not supported while running in a remote session.
    DWM_E_REMOTING_NOT_SUPPORTED = HResultCode.new('DWM_E_REMOTING_NOT_SUPPORTED', 0x80263002, '{Some Desktop Composition APIs Are Not Supported While Remoting} Some desktop composition APIs are not supported while remoting. The operation is not supported while running in a remote session.')

    # (0x80263003) {No DWM Redirection Surface is Available} The Desktop Window Manager (DWM) was unable to provide a redirection surface to complete the DirectX present.
    DWM_E_NO_REDIRECTION_SURFACE_AVAILABLE = HResultCode.new('DWM_E_NO_REDIRECTION_SURFACE_AVAILABLE', 0x80263003, '{No DWM Redirection Surface is Available} The Desktop Window Manager (DWM) was unable to provide a redirection surface to complete the DirectX present.')

    # (0x80263004) {DWM Is Not Queuing Presents for the Specified Window} The window specified is not currently using queued presents.
    DWM_E_NOT_QUEUING_PRESENTS = HResultCode.new('DWM_E_NOT_QUEUING_PRESENTS', 0x80263004, '{DWM Is Not Queuing Presents for the Specified Window} The window specified is not currently using queued presents.')

    # (0x80280000) This is an error mask to convert Trusted Platform Module (TPM) hardware errors to Win32 errors.
    TPM_E_ERROR_MASK = HResultCode.new('TPM_E_ERROR_MASK', 0x80280000, 'This is an error mask to convert Trusted Platform Module (TPM) hardware errors to Win32 errors.')

    # (0x80280001) Authentication failed.
    TPM_E_AUTHFAIL = HResultCode.new('TPM_E_AUTHFAIL', 0x80280001, 'Authentication failed.')

    # (0x80280002) The index to a Platform Configuration Register (PCR), DIR, or other register is incorrect.
    TPM_E_BADINDEX = HResultCode.new('TPM_E_BADINDEX', 0x80280002, 'The index to a Platform Configuration Register (PCR), DIR, or other register is incorrect.')

    # (0x80280003) One or more parameters are bad.
    TPM_E_BAD_PARAMETER = HResultCode.new('TPM_E_BAD_PARAMETER', 0x80280003, 'One or more parameters are bad.')

    # (0x80280004) An operation completed successfully but the auditing of that operation failed.
    TPM_E_AUDITFAILURE = HResultCode.new('TPM_E_AUDITFAILURE', 0x80280004, 'An operation completed successfully but the auditing of that operation failed.')

    # (0x80280005) The clear disable flag is set and all clear operations now require physical access.
    TPM_E_CLEAR_DISABLED = HResultCode.new('TPM_E_CLEAR_DISABLED', 0x80280005, 'The clear disable flag is set and all clear operations now require physical access.')

    # (0x80280006) The TPM is deactivated.
    TPM_E_DEACTIVATED = HResultCode.new('TPM_E_DEACTIVATED', 0x80280006, 'The TPM is deactivated.')

    # (0x80280007) The TPM is disabled.
    TPM_E_DISABLED = HResultCode.new('TPM_E_DISABLED', 0x80280007, 'The TPM is disabled.')

    # (0x80280008) The target command has been disabled.
    TPM_E_DISABLED_CMD = HResultCode.new('TPM_E_DISABLED_CMD', 0x80280008, 'The target command has been disabled.')

    # (0x80280009) The operation failed.
    TPM_E_FAIL = HResultCode.new('TPM_E_FAIL', 0x80280009, 'The operation failed.')

    # (0x8028000a) The ordinal was unknown or inconsistent.
    TPM_E_BAD_ORDINAL = HResultCode.new('TPM_E_BAD_ORDINAL', 0x8028000a, 'The ordinal was unknown or inconsistent.')

    # (0x8028000b) The ability to install an owner is disabled.
    TPM_E_INSTALL_DISABLED = HResultCode.new('TPM_E_INSTALL_DISABLED', 0x8028000b, 'The ability to install an owner is disabled.')

    # (0x8028000c) The key handle cannot be interpreted.
    TPM_E_INVALID_KEYHANDLE = HResultCode.new('TPM_E_INVALID_KEYHANDLE', 0x8028000c, 'The key handle cannot be interpreted.')

    # (0x8028000d) The key handle points to an invalid key.
    TPM_E_KEYNOTFOUND = HResultCode.new('TPM_E_KEYNOTFOUND', 0x8028000d, 'The key handle points to an invalid key.')

    # (0x8028000e) Unacceptable encryption scheme.
    TPM_E_INAPPROPRIATE_ENC = HResultCode.new('TPM_E_INAPPROPRIATE_ENC', 0x8028000e, 'Unacceptable encryption scheme.')

    # (0x8028000f) Migration authorization failed.
    TPM_E_MIGRATEFAIL = HResultCode.new('TPM_E_MIGRATEFAIL', 0x8028000f, 'Migration authorization failed.')

    # (0x80280010) PCR information could not be interpreted.
    TPM_E_INVALID_PCR_INFO = HResultCode.new('TPM_E_INVALID_PCR_INFO', 0x80280010, 'PCR information could not be interpreted.')

    # (0x80280011) No room to load key.
    TPM_E_NOSPACE = HResultCode.new('TPM_E_NOSPACE', 0x80280011, 'No room to load key.')

    # (0x80280012) There is no storage root key (SRK) set.
    TPM_E_NOSRK = HResultCode.new('TPM_E_NOSRK', 0x80280012, 'There is no storage root key (SRK) set.')

    # (0x80280013) An encrypted blob is invalid or was not created by this TPM.
    TPM_E_NOTSEALED_BLOB = HResultCode.new('TPM_E_NOTSEALED_BLOB', 0x80280013, 'An encrypted blob is invalid or was not created by this TPM.')

    # (0x80280014) There is already an owner.
    TPM_E_OWNER_SET = HResultCode.new('TPM_E_OWNER_SET', 0x80280014, 'There is already an owner.')

    # (0x80280015) The TPM has insufficient internal resources to perform the requested action.
    TPM_E_RESOURCES = HResultCode.new('TPM_E_RESOURCES', 0x80280015, 'The TPM has insufficient internal resources to perform the requested action.')

    # (0x80280016) A random string was too short.
    TPM_E_SHORTRANDOM = HResultCode.new('TPM_E_SHORTRANDOM', 0x80280016, 'A random string was too short.')

    # (0x80280017) The TPM does not have the space to perform the operation.
    TPM_E_SIZE = HResultCode.new('TPM_E_SIZE', 0x80280017, 'The TPM does not have the space to perform the operation.')

    # (0x80280018) The named PCR value does not match the current PCR value.
    TPM_E_WRONGPCRVAL = HResultCode.new('TPM_E_WRONGPCRVAL', 0x80280018, 'The named PCR value does not match the current PCR value.')

    # (0x80280019) The paramSize argument to the command has the incorrect value.
    TPM_E_BAD_PARAM_SIZE = HResultCode.new('TPM_E_BAD_PARAM_SIZE', 0x80280019, 'The paramSize argument to the command has the incorrect value.')

    # (0x8028001a) There is no existing SHA-1 thread.
    TPM_E_SHA_THREAD = HResultCode.new('TPM_E_SHA_THREAD', 0x8028001a, 'There is no existing SHA-1 thread.')

    # (0x8028001b) The calculation is unable to proceed because the existing SHA-1 thread has already encountered an error.
    TPM_E_SHA_ERROR = HResultCode.new('TPM_E_SHA_ERROR', 0x8028001b, 'The calculation is unable to proceed because the existing SHA-1 thread has already encountered an error.')

    # (0x8028001c) Self-test has failed and the TPM has shut down.
    TPM_E_FAILEDSELFTEST = HResultCode.new('TPM_E_FAILEDSELFTEST', 0x8028001c, 'Self-test has failed and the TPM has shut down.')

    # (0x8028001d) The authorization for the second key in a two-key function failed authorization.
    TPM_E_AUTH2FAIL = HResultCode.new('TPM_E_AUTH2FAIL', 0x8028001d, 'The authorization for the second key in a two-key function failed authorization.')

    # (0x8028001e) The tag value sent to for a command is invalid.
    TPM_E_BADTAG = HResultCode.new('TPM_E_BADTAG', 0x8028001e, 'The tag value sent to for a command is invalid.')

    # (0x8028001f) An I/O error occurred transmitting information to the TPM.
    TPM_E_IOERROR = HResultCode.new('TPM_E_IOERROR', 0x8028001f, 'An I/O error occurred transmitting information to the TPM.')

    # (0x80280020) The encryption process had a problem.
    TPM_E_ENCRYPT_ERROR = HResultCode.new('TPM_E_ENCRYPT_ERROR', 0x80280020, 'The encryption process had a problem.')

    # (0x80280021) The decryption process did not complete.
    TPM_E_DECRYPT_ERROR = HResultCode.new('TPM_E_DECRYPT_ERROR', 0x80280021, 'The decryption process did not complete.')

    # (0x80280022) An invalid handle was used.
    TPM_E_INVALID_AUTHHANDLE = HResultCode.new('TPM_E_INVALID_AUTHHANDLE', 0x80280022, 'An invalid handle was used.')

    # (0x80280023) The TPM does not have an endorsement key (EK) installed.
    TPM_E_NO_ENDORSEMENT = HResultCode.new('TPM_E_NO_ENDORSEMENT', 0x80280023, 'The TPM does not have an endorsement key (EK) installed.')

    # (0x80280024) The usage of a key is not allowed.
    TPM_E_INVALID_KEYUSAGE = HResultCode.new('TPM_E_INVALID_KEYUSAGE', 0x80280024, 'The usage of a key is not allowed.')

    # (0x80280025) The submitted entity type is not allowed.
    TPM_E_WRONG_ENTITYTYPE = HResultCode.new('TPM_E_WRONG_ENTITYTYPE', 0x80280025, 'The submitted entity type is not allowed.')

    # (0x80280026) The command was received in the wrong sequence relative to TPM_Init and a subsequent TPM_Startup.
    TPM_E_INVALID_POSTINIT = HResultCode.new('TPM_E_INVALID_POSTINIT', 0x80280026, 'The command was received in the wrong sequence relative to TPM_Init and a subsequent TPM_Startup.')

    # (0x80280027) Signed data cannot include additional DER information.
    TPM_E_INAPPROPRIATE_SIG = HResultCode.new('TPM_E_INAPPROPRIATE_SIG', 0x80280027, 'Signed data cannot include additional DER information.')

    # (0x80280028) The key properties in TPM_KEY_PARMs are not supported by this TPM.
    TPM_E_BAD_KEY_PROPERTY = HResultCode.new('TPM_E_BAD_KEY_PROPERTY', 0x80280028, 'The key properties in TPM_KEY_PARMs are not supported by this TPM.')

    # (0x80280029) The migration properties of this key are incorrect.
    TPM_E_BAD_MIGRATION = HResultCode.new('TPM_E_BAD_MIGRATION', 0x80280029, 'The migration properties of this key are incorrect.')

    # (0x8028002a) The signature or encryption scheme for this key is incorrect or not permitted in this situation.
    TPM_E_BAD_SCHEME = HResultCode.new('TPM_E_BAD_SCHEME', 0x8028002a, 'The signature or encryption scheme for this key is incorrect or not permitted in this situation.')

    # (0x8028002b) The size of the data (or blob) parameter is bad or inconsistent with the referenced key.
    TPM_E_BAD_DATASIZE = HResultCode.new('TPM_E_BAD_DATASIZE', 0x8028002b, 'The size of the data (or blob) parameter is bad or inconsistent with the referenced key.')

    # (0x8028002c) A mode parameter is bad, such as capArea or subCapArea for TPM_GetCapability, physicalPresence parameter for TPM_PhysicalPresence, or migrationType for TPM_CreateMigrationBlob.
    TPM_E_BAD_MODE = HResultCode.new('TPM_E_BAD_MODE', 0x8028002c, 'A mode parameter is bad, such as capArea or subCapArea for TPM_GetCapability, physicalPresence parameter for TPM_PhysicalPresence, or migrationType for TPM_CreateMigrationBlob.')

    # (0x8028002d) Either the physicalPresence or physicalPresenceLock bits have the wrong value.
    TPM_E_BAD_PRESENCE = HResultCode.new('TPM_E_BAD_PRESENCE', 0x8028002d, 'Either the physicalPresence or physicalPresenceLock bits have the wrong value.')

    # (0x8028002e) The TPM cannot perform this version of the capability.
    TPM_E_BAD_VERSION = HResultCode.new('TPM_E_BAD_VERSION', 0x8028002e, 'The TPM cannot perform this version of the capability.')

    # (0x8028002f) The TPM does not allow for wrapped transport sessions.
    TPM_E_NO_WRAP_TRANSPORT = HResultCode.new('TPM_E_NO_WRAP_TRANSPORT', 0x8028002f, 'The TPM does not allow for wrapped transport sessions.')

    # (0x80280030) TPM audit construction failed and the underlying command was returning a failure code also.
    TPM_E_AUDITFAIL_UNSUCCESSFUL = HResultCode.new('TPM_E_AUDITFAIL_UNSUCCESSFUL', 0x80280030, 'TPM audit construction failed and the underlying command was returning a failure code also.')

    # (0x80280031) TPM audit construction failed and the underlying command was returning success.
    TPM_E_AUDITFAIL_SUCCESSFUL = HResultCode.new('TPM_E_AUDITFAIL_SUCCESSFUL', 0x80280031, 'TPM audit construction failed and the underlying command was returning success.')

    # (0x80280032) Attempt to reset a PCR that does not have the resettable attribute.
    TPM_E_NOTRESETABLE = HResultCode.new('TPM_E_NOTRESETABLE', 0x80280032, 'Attempt to reset a PCR that does not have the resettable attribute.')

    # (0x80280033) Attempt to reset a PCR register that requires locality and the locality modifier not part of command transport.
    TPM_E_NOTLOCAL = HResultCode.new('TPM_E_NOTLOCAL', 0x80280033, 'Attempt to reset a PCR register that requires locality and the locality modifier not part of command transport.')

    # (0x80280034) Make identity blob not properly typed.
    TPM_E_BAD_TYPE = HResultCode.new('TPM_E_BAD_TYPE', 0x80280034, 'Make identity blob not properly typed.')

    # (0x80280035) When saving context identified resource type does not match actual resource.
    TPM_E_INVALID_RESOURCE = HResultCode.new('TPM_E_INVALID_RESOURCE', 0x80280035, 'When saving context identified resource type does not match actual resource.')

    # (0x80280036) The TPM is attempting to execute a command only available when in Federal Information Processing Standards (FIPS) mode.
    TPM_E_NOTFIPS = HResultCode.new('TPM_E_NOTFIPS', 0x80280036, 'The TPM is attempting to execute a command only available when in Federal Information Processing Standards (FIPS) mode.')

    # (0x80280037) The command is attempting to use an invalid family ID.
    TPM_E_INVALID_FAMILY = HResultCode.new('TPM_E_INVALID_FAMILY', 0x80280037, 'The command is attempting to use an invalid family ID.')

    # (0x80280038) The permission to manipulate the NV storage is not available.
    TPM_E_NO_NV_PERMISSION = HResultCode.new('TPM_E_NO_NV_PERMISSION', 0x80280038, 'The permission to manipulate the NV storage is not available.')

    # (0x80280039) The operation requires a signed command.
    TPM_E_REQUIRES_SIGN = HResultCode.new('TPM_E_REQUIRES_SIGN', 0x80280039, 'The operation requires a signed command.')

    # (0x8028003a) Wrong operation to load an NV key.
    TPM_E_KEY_NOTSUPPORTED = HResultCode.new('TPM_E_KEY_NOTSUPPORTED', 0x8028003a, 'Wrong operation to load an NV key.')

    # (0x8028003b) NV_LoadKey blob requires both owner and blob authorization.
    TPM_E_AUTH_CONFLICT = HResultCode.new('TPM_E_AUTH_CONFLICT', 0x8028003b, 'NV_LoadKey blob requires both owner and blob authorization.')

    # (0x8028003c) The NV area is locked and not writable.
    TPM_E_AREA_LOCKED = HResultCode.new('TPM_E_AREA_LOCKED', 0x8028003c, 'The NV area is locked and not writable.')

    # (0x8028003d) The locality is incorrect for the attempted operation.
    TPM_E_BAD_LOCALITY = HResultCode.new('TPM_E_BAD_LOCALITY', 0x8028003d, 'The locality is incorrect for the attempted operation.')

    # (0x8028003e) The NV area is read-only and cannot be written to.
    TPM_E_READ_ONLY = HResultCode.new('TPM_E_READ_ONLY', 0x8028003e, 'The NV area is read-only and cannot be written to.')

    # (0x8028003f) There is no protection on the write to the NV area.
    TPM_E_PER_NOWRITE = HResultCode.new('TPM_E_PER_NOWRITE', 0x8028003f, 'There is no protection on the write to the NV area.')

    # (0x80280040) The family count value does not match.
    TPM_E_FAMILYCOUNT = HResultCode.new('TPM_E_FAMILYCOUNT', 0x80280040, 'The family count value does not match.')

    # (0x80280041) The NV area has already been written to.
    TPM_E_WRITE_LOCKED = HResultCode.new('TPM_E_WRITE_LOCKED', 0x80280041, 'The NV area has already been written to.')

    # (0x80280042) The NV area attributes conflict.
    TPM_E_BAD_ATTRIBUTES = HResultCode.new('TPM_E_BAD_ATTRIBUTES', 0x80280042, 'The NV area attributes conflict.')

    # (0x80280043) The structure tag and version are invalid or inconsistent.
    TPM_E_INVALID_STRUCTURE = HResultCode.new('TPM_E_INVALID_STRUCTURE', 0x80280043, 'The structure tag and version are invalid or inconsistent.')

    # (0x80280044) The key is under control of the TPM owner and can only be evicted by the TPM owner.
    TPM_E_KEY_OWNER_CONTROL = HResultCode.new('TPM_E_KEY_OWNER_CONTROL', 0x80280044, 'The key is under control of the TPM owner and can only be evicted by the TPM owner.')

    # (0x80280045) The counter handle is incorrect.
    TPM_E_BAD_COUNTER = HResultCode.new('TPM_E_BAD_COUNTER', 0x80280045, 'The counter handle is incorrect.')

    # (0x80280046) The write is not a complete write of the area.
    TPM_E_NOT_FULLWRITE = HResultCode.new('TPM_E_NOT_FULLWRITE', 0x80280046, 'The write is not a complete write of the area.')

    # (0x80280047) The gap between saved context counts is too large.
    TPM_E_CONTEXT_GAP = HResultCode.new('TPM_E_CONTEXT_GAP', 0x80280047, 'The gap between saved context counts is too large.')

    # (0x80280048) The maximum number of NV writes without an owner has been exceeded.
    TPM_E_MAXNVWRITES = HResultCode.new('TPM_E_MAXNVWRITES', 0x80280048, 'The maximum number of NV writes without an owner has been exceeded.')

    # (0x80280049) No operator AuthData value is set.
    TPM_E_NOOPERATOR = HResultCode.new('TPM_E_NOOPERATOR', 0x80280049, 'No operator AuthData value is set.')

    # (0x8028004a) The resource pointed to by context is not loaded.
    TPM_E_RESOURCEMISSING = HResultCode.new('TPM_E_RESOURCEMISSING', 0x8028004a, 'The resource pointed to by context is not loaded.')

    # (0x8028004b) The delegate administration is locked.
    TPM_E_DELEGATE_LOCK = HResultCode.new('TPM_E_DELEGATE_LOCK', 0x8028004b, 'The delegate administration is locked.')

    # (0x8028004c) Attempt to manage a family other then the delegated family.
    TPM_E_DELEGATE_FAMILY = HResultCode.new('TPM_E_DELEGATE_FAMILY', 0x8028004c, 'Attempt to manage a family other then the delegated family.')

    # (0x8028004d) Delegation table management not enabled.
    TPM_E_DELEGATE_ADMIN = HResultCode.new('TPM_E_DELEGATE_ADMIN', 0x8028004d, 'Delegation table management not enabled.')

    # (0x8028004e) There was a command executed outside an exclusive transport session.
    TPM_E_TRANSPORT_NOTEXCLUSIVE = HResultCode.new('TPM_E_TRANSPORT_NOTEXCLUSIVE', 0x8028004e, 'There was a command executed outside an exclusive transport session.')

    # (0x8028004f) Attempt to context save an owner evict controlled key.
    TPM_E_OWNER_CONTROL = HResultCode.new('TPM_E_OWNER_CONTROL', 0x8028004f, 'Attempt to context save an owner evict controlled key.')

    # (0x80280050) The DAA command has no resources available to execute the command.
    TPM_E_DAA_RESOURCES = HResultCode.new('TPM_E_DAA_RESOURCES', 0x80280050, 'The DAA command has no resources available to execute the command.')

    # (0x80280051) The consistency check on DAA parameter inputData0 has failed.
    TPM_E_DAA_INPUT_DATA0 = HResultCode.new('TPM_E_DAA_INPUT_DATA0', 0x80280051, 'The consistency check on DAA parameter inputData0 has failed.')

    # (0x80280052) The consistency check on DAA parameter inputData1 has failed.
    TPM_E_DAA_INPUT_DATA1 = HResultCode.new('TPM_E_DAA_INPUT_DATA1', 0x80280052, 'The consistency check on DAA parameter inputData1 has failed.')

    # (0x80280053) The consistency check on DAA_issuerSettings has failed.
    TPM_E_DAA_ISSUER_SETTINGS = HResultCode.new('TPM_E_DAA_ISSUER_SETTINGS', 0x80280053, 'The consistency check on DAA_issuerSettings has failed.')

    # (0x80280054) The consistency check on DAA_tpmSpecific has failed.
    TPM_E_DAA_TPM_SETTINGS = HResultCode.new('TPM_E_DAA_TPM_SETTINGS', 0x80280054, 'The consistency check on DAA_tpmSpecific has failed.')

    # (0x80280055) The atomic process indicated by the submitted DAA command is not the expected process.
    TPM_E_DAA_STAGE = HResultCode.new('TPM_E_DAA_STAGE', 0x80280055, 'The atomic process indicated by the submitted DAA command is not the expected process.')

    # (0x80280056) The issuer's validity check has detected an inconsistency.
    TPM_E_DAA_ISSUER_VALIDITY = HResultCode.new('TPM_E_DAA_ISSUER_VALIDITY', 0x80280056, 'The issuer\'s validity check has detected an inconsistency.')

    # (0x80280057) The consistency check on w has failed.
    TPM_E_DAA_WRONG_W = HResultCode.new('TPM_E_DAA_WRONG_W', 0x80280057, 'The consistency check on w has failed.')

    # (0x80280058) The handle is incorrect.
    TPM_E_BAD_HANDLE = HResultCode.new('TPM_E_BAD_HANDLE', 0x80280058, 'The handle is incorrect.')

    # (0x80280059) Delegation is not correct.
    TPM_E_BAD_DELEGATE = HResultCode.new('TPM_E_BAD_DELEGATE', 0x80280059, 'Delegation is not correct.')

    # (0x8028005a) The context blob is invalid.
    TPM_E_BADCONTEXT = HResultCode.new('TPM_E_BADCONTEXT', 0x8028005a, 'The context blob is invalid.')

    # (0x8028005b) Too many contexts held by the TPM.
    TPM_E_TOOMANYCONTEXTS = HResultCode.new('TPM_E_TOOMANYCONTEXTS', 0x8028005b, 'Too many contexts held by the TPM.')

    # (0x8028005c) Migration authority signature validation failure.
    TPM_E_MA_TICKET_SIGNATURE = HResultCode.new('TPM_E_MA_TICKET_SIGNATURE', 0x8028005c, 'Migration authority signature validation failure.')

    # (0x8028005d) Migration destination not authenticated.
    TPM_E_MA_DESTINATION = HResultCode.new('TPM_E_MA_DESTINATION', 0x8028005d, 'Migration destination not authenticated.')

    # (0x8028005e) Migration source incorrect.
    TPM_E_MA_SOURCE = HResultCode.new('TPM_E_MA_SOURCE', 0x8028005e, 'Migration source incorrect.')

    # (0x8028005f) Incorrect migration authority.
    TPM_E_MA_AUTHORITY = HResultCode.new('TPM_E_MA_AUTHORITY', 0x8028005f, 'Incorrect migration authority.')

    # (0x80280061) Attempt to revoke the EK and the EK is not revocable.
    TPM_E_PERMANENTEK = HResultCode.new('TPM_E_PERMANENTEK', 0x80280061, 'Attempt to revoke the EK and the EK is not revocable.')

    # (0x80280062) Bad signature of CMK ticket.
    TPM_E_BAD_SIGNATURE = HResultCode.new('TPM_E_BAD_SIGNATURE', 0x80280062, 'Bad signature of CMK ticket.')

    # (0x80280063) There is no room in the context list for additional contexts.
    TPM_E_NOCONTEXTSPACE = HResultCode.new('TPM_E_NOCONTEXTSPACE', 0x80280063, 'There is no room in the context list for additional contexts.')

    # (0x80280400) The command was blocked.
    TPM_E_COMMAND_BLOCKED = HResultCode.new('TPM_E_COMMAND_BLOCKED', 0x80280400, 'The command was blocked.')

    # (0x80280401) The specified handle was not found.
    TPM_E_INVALID_HANDLE = HResultCode.new('TPM_E_INVALID_HANDLE', 0x80280401, 'The specified handle was not found.')

    # (0x80280402) The TPM returned a duplicate handle and the command needs to be resubmitted.
    TPM_E_DUPLICATE_VHANDLE = HResultCode.new('TPM_E_DUPLICATE_VHANDLE', 0x80280402, 'The TPM returned a duplicate handle and the command needs to be resubmitted.')

    # (0x80280403) The command within the transport was blocked.
    TPM_E_EMBEDDED_COMMAND_BLOCKED = HResultCode.new('TPM_E_EMBEDDED_COMMAND_BLOCKED', 0x80280403, 'The command within the transport was blocked.')

    # (0x80280404) The command within the transport is not supported.
    TPM_E_EMBEDDED_COMMAND_UNSUPPORTED = HResultCode.new('TPM_E_EMBEDDED_COMMAND_UNSUPPORTED', 0x80280404, 'The command within the transport is not supported.')

    # (0x80280800) The TPM is too busy to respond to the command immediately, but the command could be resubmitted at a later time.
    TPM_E_RETRY = HResultCode.new('TPM_E_RETRY', 0x80280800, 'The TPM is too busy to respond to the command immediately, but the command could be resubmitted at a later time.')

    # (0x80280801) SelfTestFull has not been run.
    TPM_E_NEEDS_SELFTEST = HResultCode.new('TPM_E_NEEDS_SELFTEST', 0x80280801, 'SelfTestFull has not been run.')

    # (0x80280802) The TPM is currently executing a full self-test.
    TPM_E_DOING_SELFTEST = HResultCode.new('TPM_E_DOING_SELFTEST', 0x80280802, 'The TPM is currently executing a full self-test.')

    # (0x80280803) The TPM is defending against dictionary attacks and is in a time-out period.
    TPM_E_DEFEND_LOCK_RUNNING = HResultCode.new('TPM_E_DEFEND_LOCK_RUNNING', 0x80280803, 'The TPM is defending against dictionary attacks and is in a time-out period.')

    # (0x80284001) An internal software error has been detected.
    TBS_E_INTERNAL_ERROR = HResultCode.new('TBS_E_INTERNAL_ERROR', 0x80284001, 'An internal software error has been detected.')

    # (0x80284002) One or more input parameters are bad.
    TBS_E_BAD_PARAMETER = HResultCode.new('TBS_E_BAD_PARAMETER', 0x80284002, 'One or more input parameters are bad.')

    # (0x80284003) A specified output pointer is bad.
    TBS_E_INVALID_OUTPUT_POINTER = HResultCode.new('TBS_E_INVALID_OUTPUT_POINTER', 0x80284003, 'A specified output pointer is bad.')

    # (0x80284004) The specified context handle does not refer to a valid context.
    TBS_E_INVALID_CONTEXT = HResultCode.new('TBS_E_INVALID_CONTEXT', 0x80284004, 'The specified context handle does not refer to a valid context.')

    # (0x80284005) A specified output buffer is too small.
    TBS_E_INSUFFICIENT_BUFFER = HResultCode.new('TBS_E_INSUFFICIENT_BUFFER', 0x80284005, 'A specified output buffer is too small.')

    # (0x80284006) An error occurred while communicating with the TPM.
    TBS_E_IOERROR = HResultCode.new('TBS_E_IOERROR', 0x80284006, 'An error occurred while communicating with the TPM.')

    # (0x80284007) One or more context parameters are invalid.
    TBS_E_INVALID_CONTEXT_PARAM = HResultCode.new('TBS_E_INVALID_CONTEXT_PARAM', 0x80284007, 'One or more context parameters are invalid.')

    # (0x80284008) The TPM Base Services (TBS) is not running and could not be started.
    TBS_E_SERVICE_NOT_RUNNING = HResultCode.new('TBS_E_SERVICE_NOT_RUNNING', 0x80284008, 'The TPM Base Services (TBS) is not running and could not be started.')

    # (0x80284009) A new context could not be created because there are too many open contexts.
    TBS_E_TOO_MANY_TBS_CONTEXTS = HResultCode.new('TBS_E_TOO_MANY_TBS_CONTEXTS', 0x80284009, 'A new context could not be created because there are too many open contexts.')

    # (0x8028400a) A new virtual resource could not be created because there are too many open virtual resources.
    TBS_E_TOO_MANY_RESOURCES = HResultCode.new('TBS_E_TOO_MANY_RESOURCES', 0x8028400a, 'A new virtual resource could not be created because there are too many open virtual resources.')

    # (0x8028400b) The TBS service has been started but is not yet running.
    TBS_E_SERVICE_START_PENDING = HResultCode.new('TBS_E_SERVICE_START_PENDING', 0x8028400b, 'The TBS service has been started but is not yet running.')

    # (0x8028400c) The physical presence interface is not supported.
    TBS_E_PPI_NOT_SUPPORTED = HResultCode.new('TBS_E_PPI_NOT_SUPPORTED', 0x8028400c, 'The physical presence interface is not supported.')

    # (0x8028400d) The command was canceled.
    TBS_E_COMMAND_CANCELED = HResultCode.new('TBS_E_COMMAND_CANCELED', 0x8028400d, 'The command was canceled.')

    # (0x8028400e) The input or output buffer is too large.
    TBS_E_BUFFER_TOO_LARGE = HResultCode.new('TBS_E_BUFFER_TOO_LARGE', 0x8028400e, 'The input or output buffer is too large.')

    # (0x80290100) The command buffer is not in the correct state.
    TPMAPI_E_INVALID_STATE = HResultCode.new('TPMAPI_E_INVALID_STATE', 0x80290100, 'The command buffer is not in the correct state.')

    # (0x80290101) The command buffer does not contain enough data to satisfy the request.
    TPMAPI_E_NOT_ENOUGH_DATA = HResultCode.new('TPMAPI_E_NOT_ENOUGH_DATA', 0x80290101, 'The command buffer does not contain enough data to satisfy the request.')

    # (0x80290102) The command buffer cannot contain any more data.
    TPMAPI_E_TOO_MUCH_DATA = HResultCode.new('TPMAPI_E_TOO_MUCH_DATA', 0x80290102, 'The command buffer cannot contain any more data.')

    # (0x80290103) One or more output parameters was null or invalid.
    TPMAPI_E_INVALID_OUTPUT_POINTER = HResultCode.new('TPMAPI_E_INVALID_OUTPUT_POINTER', 0x80290103, 'One or more output parameters was null or invalid.')

    # (0x80290104) One or more input parameters are invalid.
    TPMAPI_E_INVALID_PARAMETER = HResultCode.new('TPMAPI_E_INVALID_PARAMETER', 0x80290104, 'One or more input parameters are invalid.')

    # (0x80290105) Not enough memory was available to satisfy the request.
    TPMAPI_E_OUT_OF_MEMORY = HResultCode.new('TPMAPI_E_OUT_OF_MEMORY', 0x80290105, 'Not enough memory was available to satisfy the request.')

    # (0x80290106) The specified buffer was too small.
    TPMAPI_E_BUFFER_TOO_SMALL = HResultCode.new('TPMAPI_E_BUFFER_TOO_SMALL', 0x80290106, 'The specified buffer was too small.')

    # (0x80290107) An internal error was detected.
    TPMAPI_E_INTERNAL_ERROR = HResultCode.new('TPMAPI_E_INTERNAL_ERROR', 0x80290107, 'An internal error was detected.')

    # (0x80290108) The caller does not have the appropriate rights to perform the requested operation.
    TPMAPI_E_ACCESS_DENIED = HResultCode.new('TPMAPI_E_ACCESS_DENIED', 0x80290108, 'The caller does not have the appropriate rights to perform the requested operation.')

    # (0x80290109) The specified authorization information was invalid.
    TPMAPI_E_AUTHORIZATION_FAILED = HResultCode.new('TPMAPI_E_AUTHORIZATION_FAILED', 0x80290109, 'The specified authorization information was invalid.')

    # (0x8029010a) The specified context handle was not valid.
    TPMAPI_E_INVALID_CONTEXT_HANDLE = HResultCode.new('TPMAPI_E_INVALID_CONTEXT_HANDLE', 0x8029010a, 'The specified context handle was not valid.')

    # (0x8029010b) An error occurred while communicating with the TBS.
    TPMAPI_E_TBS_COMMUNICATION_ERROR = HResultCode.new('TPMAPI_E_TBS_COMMUNICATION_ERROR', 0x8029010b, 'An error occurred while communicating with the TBS.')

    # (0x8029010c) The TPM returned an unexpected result.
    TPMAPI_E_TPM_COMMAND_ERROR = HResultCode.new('TPMAPI_E_TPM_COMMAND_ERROR', 0x8029010c, 'The TPM returned an unexpected result.')

    # (0x8029010d) The message was too large for the encoding scheme.
    TPMAPI_E_MESSAGE_TOO_LARGE = HResultCode.new('TPMAPI_E_MESSAGE_TOO_LARGE', 0x8029010d, 'The message was too large for the encoding scheme.')

    # (0x8029010e) The encoding in the binary large object (BLOB) was not recognized.
    TPMAPI_E_INVALID_ENCODING = HResultCode.new('TPMAPI_E_INVALID_ENCODING', 0x8029010e, 'The encoding in the binary large object (BLOB) was not recognized.')

    # (0x8029010f) The key size is not valid.
    TPMAPI_E_INVALID_KEY_SIZE = HResultCode.new('TPMAPI_E_INVALID_KEY_SIZE', 0x8029010f, 'The key size is not valid.')

    # (0x80290110) The encryption operation failed.
    TPMAPI_E_ENCRYPTION_FAILED = HResultCode.new('TPMAPI_E_ENCRYPTION_FAILED', 0x80290110, 'The encryption operation failed.')

    # (0x80290111) The key parameters structure was not valid.
    TPMAPI_E_INVALID_KEY_PARAMS = HResultCode.new('TPMAPI_E_INVALID_KEY_PARAMS', 0x80290111, 'The key parameters structure was not valid.')

    # (0x80290112) The requested supplied data does not appear to be a valid migration authorization BLOB.
    TPMAPI_E_INVALID_MIGRATION_AUTHORIZATION_BLOB = HResultCode.new('TPMAPI_E_INVALID_MIGRATION_AUTHORIZATION_BLOB', 0x80290112, 'The requested supplied data does not appear to be a valid migration authorization BLOB.')

    # (0x80290113) The specified PCR index was invalid.
    TPMAPI_E_INVALID_PCR_INDEX = HResultCode.new('TPMAPI_E_INVALID_PCR_INDEX', 0x80290113, 'The specified PCR index was invalid.')

    # (0x80290114) The data given does not appear to be a valid delegate BLOB.
    TPMAPI_E_INVALID_DELEGATE_BLOB = HResultCode.new('TPMAPI_E_INVALID_DELEGATE_BLOB', 0x80290114, 'The data given does not appear to be a valid delegate BLOB.')

    # (0x80290115) One or more of the specified context parameters was not valid.
    TPMAPI_E_INVALID_CONTEXT_PARAMS = HResultCode.new('TPMAPI_E_INVALID_CONTEXT_PARAMS', 0x80290115, 'One or more of the specified context parameters was not valid.')

    # (0x80290116) The data given does not appear to be a valid key BLOB.
    TPMAPI_E_INVALID_KEY_BLOB = HResultCode.new('TPMAPI_E_INVALID_KEY_BLOB', 0x80290116, 'The data given does not appear to be a valid key BLOB.')

    # (0x80290117) The specified PCR data was invalid.
    TPMAPI_E_INVALID_PCR_DATA = HResultCode.new('TPMAPI_E_INVALID_PCR_DATA', 0x80290117, 'The specified PCR data was invalid.')

    # (0x80290118) The format of the owner authorization data was invalid.
    TPMAPI_E_INVALID_OWNER_AUTH = HResultCode.new('TPMAPI_E_INVALID_OWNER_AUTH', 0x80290118, 'The format of the owner authorization data was invalid.')

    # (0x80290200) The specified buffer was too small.
    TBSIMP_E_BUFFER_TOO_SMALL = HResultCode.new('TBSIMP_E_BUFFER_TOO_SMALL', 0x80290200, 'The specified buffer was too small.')

    # (0x80290201) The context could not be cleaned up.
    TBSIMP_E_CLEANUP_FAILED = HResultCode.new('TBSIMP_E_CLEANUP_FAILED', 0x80290201, 'The context could not be cleaned up.')

    # (0x80290202) The specified context handle is invalid.
    TBSIMP_E_INVALID_CONTEXT_HANDLE = HResultCode.new('TBSIMP_E_INVALID_CONTEXT_HANDLE', 0x80290202, 'The specified context handle is invalid.')

    # (0x80290203) An invalid context parameter was specified.
    TBSIMP_E_INVALID_CONTEXT_PARAM = HResultCode.new('TBSIMP_E_INVALID_CONTEXT_PARAM', 0x80290203, 'An invalid context parameter was specified.')

    # (0x80290204) An error occurred while communicating with the TPM.
    TBSIMP_E_TPM_ERROR = HResultCode.new('TBSIMP_E_TPM_ERROR', 0x80290204, 'An error occurred while communicating with the TPM.')

    # (0x80290205) No entry with the specified key was found.
    TBSIMP_E_HASH_BAD_KEY = HResultCode.new('TBSIMP_E_HASH_BAD_KEY', 0x80290205, 'No entry with the specified key was found.')

    # (0x80290206) The specified virtual handle matches a virtual handle already in use.
    TBSIMP_E_DUPLICATE_VHANDLE = HResultCode.new('TBSIMP_E_DUPLICATE_VHANDLE', 0x80290206, 'The specified virtual handle matches a virtual handle already in use.')

    # (0x80290207) The pointer to the returned handle location was null or invalid.
    TBSIMP_E_INVALID_OUTPUT_POINTER = HResultCode.new('TBSIMP_E_INVALID_OUTPUT_POINTER', 0x80290207, 'The pointer to the returned handle location was null or invalid.')

    # (0x80290208) One or more parameters are invalid.
    TBSIMP_E_INVALID_PARAMETER = HResultCode.new('TBSIMP_E_INVALID_PARAMETER', 0x80290208, 'One or more parameters are invalid.')

    # (0x80290209) The RPC subsystem could not be initialized.
    TBSIMP_E_RPC_INIT_FAILED = HResultCode.new('TBSIMP_E_RPC_INIT_FAILED', 0x80290209, 'The RPC subsystem could not be initialized.')

    # (0x8029020a) The TBS scheduler is not running.
    TBSIMP_E_SCHEDULER_NOT_RUNNING = HResultCode.new('TBSIMP_E_SCHEDULER_NOT_RUNNING', 0x8029020a, 'The TBS scheduler is not running.')

    # (0x8029020b) The command was canceled.
    TBSIMP_E_COMMAND_CANCELED = HResultCode.new('TBSIMP_E_COMMAND_CANCELED', 0x8029020b, 'The command was canceled.')

    # (0x8029020c) There was not enough memory to fulfill the request.
    TBSIMP_E_OUT_OF_MEMORY = HResultCode.new('TBSIMP_E_OUT_OF_MEMORY', 0x8029020c, 'There was not enough memory to fulfill the request.')

    # (0x8029020d) The specified list is empty, or the iteration has reached the end of the list.
    TBSIMP_E_LIST_NO_MORE_ITEMS = HResultCode.new('TBSIMP_E_LIST_NO_MORE_ITEMS', 0x8029020d, 'The specified list is empty, or the iteration has reached the end of the list.')

    # (0x8029020e) The specified item was not found in the list.
    TBSIMP_E_LIST_NOT_FOUND = HResultCode.new('TBSIMP_E_LIST_NOT_FOUND', 0x8029020e, 'The specified item was not found in the list.')

    # (0x8029020f) The TPM does not have enough space to load the requested resource.
    TBSIMP_E_NOT_ENOUGH_SPACE = HResultCode.new('TBSIMP_E_NOT_ENOUGH_SPACE', 0x8029020f, 'The TPM does not have enough space to load the requested resource.')

    # (0x80290210) There are too many TPM contexts in use.
    TBSIMP_E_NOT_ENOUGH_TPM_CONTEXTS = HResultCode.new('TBSIMP_E_NOT_ENOUGH_TPM_CONTEXTS', 0x80290210, 'There are too many TPM contexts in use.')

    # (0x80290211) The TPM command failed.
    TBSIMP_E_COMMAND_FAILED = HResultCode.new('TBSIMP_E_COMMAND_FAILED', 0x80290211, 'The TPM command failed.')

    # (0x80290212) The TBS does not recognize the specified ordinal.
    TBSIMP_E_UNKNOWN_ORDINAL = HResultCode.new('TBSIMP_E_UNKNOWN_ORDINAL', 0x80290212, 'The TBS does not recognize the specified ordinal.')

    # (0x80290213) The requested resource is no longer available.
    TBSIMP_E_RESOURCE_EXPIRED = HResultCode.new('TBSIMP_E_RESOURCE_EXPIRED', 0x80290213, 'The requested resource is no longer available.')

    # (0x80290214) The resource type did not match.
    TBSIMP_E_INVALID_RESOURCE = HResultCode.new('TBSIMP_E_INVALID_RESOURCE', 0x80290214, 'The resource type did not match.')

    # (0x80290215) No resources can be unloaded.
    TBSIMP_E_NOTHING_TO_UNLOAD = HResultCode.new('TBSIMP_E_NOTHING_TO_UNLOAD', 0x80290215, 'No resources can be unloaded.')

    # (0x80290216) No new entries can be added to the hash table.
    TBSIMP_E_HASH_TABLE_FULL = HResultCode.new('TBSIMP_E_HASH_TABLE_FULL', 0x80290216, 'No new entries can be added to the hash table.')

    # (0x80290217) A new TBS context could not be created because there are too many open contexts.
    TBSIMP_E_TOO_MANY_TBS_CONTEXTS = HResultCode.new('TBSIMP_E_TOO_MANY_TBS_CONTEXTS', 0x80290217, 'A new TBS context could not be created because there are too many open contexts.')

    # (0x80290218) A new virtual resource could not be created because there are too many open virtual resources.
    TBSIMP_E_TOO_MANY_RESOURCES = HResultCode.new('TBSIMP_E_TOO_MANY_RESOURCES', 0x80290218, 'A new virtual resource could not be created because there are too many open virtual resources.')

    # (0x80290219) The physical presence interface is not supported.
    TBSIMP_E_PPI_NOT_SUPPORTED = HResultCode.new('TBSIMP_E_PPI_NOT_SUPPORTED', 0x80290219, 'The physical presence interface is not supported.')

    # (0x8029021a) TBS is not compatible with the version of TPM found on the system.
    TBSIMP_E_TPM_INCOMPATIBLE = HResultCode.new('TBSIMP_E_TPM_INCOMPATIBLE', 0x8029021a, 'TBS is not compatible with the version of TPM found on the system.')

    # (0x80290300) A general error was detected when attempting to acquire the BIOS response to a physical presence command.
    TPM_E_PPI_ACPI_FAILURE = HResultCode.new('TPM_E_PPI_ACPI_FAILURE', 0x80290300, 'A general error was detected when attempting to acquire the BIOS response to a physical presence command.')

    # (0x80290301) The user failed to confirm the TPM operation request.
    TPM_E_PPI_USER_ABORT = HResultCode.new('TPM_E_PPI_USER_ABORT', 0x80290301, 'The user failed to confirm the TPM operation request.')

    # (0x80290302) The BIOS failure prevented the successful execution of the requested TPM operation (for example, invalid TPM operation request, BIOS communication error with the TPM).
    TPM_E_PPI_BIOS_FAILURE = HResultCode.new('TPM_E_PPI_BIOS_FAILURE', 0x80290302, 'The BIOS failure prevented the successful execution of the requested TPM operation (for example, invalid TPM operation request, BIOS communication error with the TPM).')

    # (0x80290303) The BIOS does not support the physical presence interface.
    TPM_E_PPI_NOT_SUPPORTED = HResultCode.new('TPM_E_PPI_NOT_SUPPORTED', 0x80290303, 'The BIOS does not support the physical presence interface.')

    # (0x80300002) A Data Collector Set was not found.
    PLA_E_DCS_NOT_FOUND = HResultCode.new('PLA_E_DCS_NOT_FOUND', 0x80300002, 'A Data Collector Set was not found.')

    # (0x80300045) Unable to start Data Collector Set because there are too many folders.
    PLA_E_TOO_MANY_FOLDERS = HResultCode.new('PLA_E_TOO_MANY_FOLDERS', 0x80300045, 'Unable to start Data Collector Set because there are too many folders.')

    # (0x80300070) Not enough free disk space to start Data Collector Set.
    PLA_E_NO_MIN_DISK = HResultCode.new('PLA_E_NO_MIN_DISK', 0x80300070, 'Not enough free disk space to start Data Collector Set.')

    # (0x803000aa) Data Collector Set is in use.
    PLA_E_DCS_IN_USE = HResultCode.new('PLA_E_DCS_IN_USE', 0x803000aa, 'Data Collector Set is in use.')

    # (0x803000b7) Data Collector Set already exists.
    PLA_E_DCS_ALREADY_EXISTS = HResultCode.new('PLA_E_DCS_ALREADY_EXISTS', 0x803000b7, 'Data Collector Set already exists.')

    # (0x80300101) Property value conflict.
    PLA_E_PROPERTY_CONFLICT = HResultCode.new('PLA_E_PROPERTY_CONFLICT', 0x80300101, 'Property value conflict.')

    # (0x80300102) The current configuration for this Data Collector Set requires that it contain exactly one Data Collector.
    PLA_E_DCS_SINGLETON_REQUIRED = HResultCode.new('PLA_E_DCS_SINGLETON_REQUIRED', 0x80300102, 'The current configuration for this Data Collector Set requires that it contain exactly one Data Collector.')

    # (0x80300103) A user account is required to commit the current Data Collector Set properties.
    PLA_E_CREDENTIALS_REQUIRED = HResultCode.new('PLA_E_CREDENTIALS_REQUIRED', 0x80300103, 'A user account is required to commit the current Data Collector Set properties.')

    # (0x80300104) Data Collector Set is not running.
    PLA_E_DCS_NOT_RUNNING = HResultCode.new('PLA_E_DCS_NOT_RUNNING', 0x80300104, 'Data Collector Set is not running.')

    # (0x80300105) A conflict was detected in the list of include and exclude APIs. Do not specify the same API in both the include list and the exclude list.
    PLA_E_CONFLICT_INCL_EXCL_API = HResultCode.new('PLA_E_CONFLICT_INCL_EXCL_API', 0x80300105, 'A conflict was detected in the list of include and exclude APIs. Do not specify the same API in both the include list and the exclude list.')

    # (0x80300106) The executable path specified refers to a network share or UNC path.
    PLA_E_NETWORK_EXE_NOT_VALID = HResultCode.new('PLA_E_NETWORK_EXE_NOT_VALID', 0x80300106, 'The executable path specified refers to a network share or UNC path.')

    # (0x80300107) The executable path specified is already configured for API tracing.
    PLA_E_EXE_ALREADY_CONFIGURED = HResultCode.new('PLA_E_EXE_ALREADY_CONFIGURED', 0x80300107, 'The executable path specified is already configured for API tracing.')

    # (0x80300108) The executable path specified does not exist. Verify that the specified path is correct.
    PLA_E_EXE_PATH_NOT_VALID = HResultCode.new('PLA_E_EXE_PATH_NOT_VALID', 0x80300108, 'The executable path specified does not exist. Verify that the specified path is correct.')

    # (0x80300109) Data Collector already exists.
    PLA_E_DC_ALREADY_EXISTS = HResultCode.new('PLA_E_DC_ALREADY_EXISTS', 0x80300109, 'Data Collector already exists.')

    # (0x8030010a) The wait for the Data Collector Set start notification has timed out.
    PLA_E_DCS_START_WAIT_TIMEOUT = HResultCode.new('PLA_E_DCS_START_WAIT_TIMEOUT', 0x8030010a, 'The wait for the Data Collector Set start notification has timed out.')

    # (0x8030010b) The wait for the Data Collector to start has timed out.
    PLA_E_DC_START_WAIT_TIMEOUT = HResultCode.new('PLA_E_DC_START_WAIT_TIMEOUT', 0x8030010b, 'The wait for the Data Collector to start has timed out.')

    # (0x8030010c) The wait for the report generation tool to finish has timed out.
    PLA_E_REPORT_WAIT_TIMEOUT = HResultCode.new('PLA_E_REPORT_WAIT_TIMEOUT', 0x8030010c, 'The wait for the report generation tool to finish has timed out.')

    # (0x8030010d) Duplicate items are not allowed.
    PLA_E_NO_DUPLICATES = HResultCode.new('PLA_E_NO_DUPLICATES', 0x8030010d, 'Duplicate items are not allowed.')

    # (0x8030010e) When specifying the executable to trace, you must specify a full path to the executable and not just a file name.
    PLA_E_EXE_FULL_PATH_REQUIRED = HResultCode.new('PLA_E_EXE_FULL_PATH_REQUIRED', 0x8030010e, 'When specifying the executable to trace, you must specify a full path to the executable and not just a file name.')

    # (0x8030010f) The session name provided is invalid.
    PLA_E_INVALID_SESSION_NAME = HResultCode.new('PLA_E_INVALID_SESSION_NAME', 0x8030010f, 'The session name provided is invalid.')

    # (0x80300110) The Event Log channel Microsoft-Windows-Diagnosis-PLA/Operational must be enabled to perform this operation.
    PLA_E_PLA_CHANNEL_NOT_ENABLED = HResultCode.new('PLA_E_PLA_CHANNEL_NOT_ENABLED', 0x80300110, 'The Event Log channel Microsoft-Windows-Diagnosis-PLA/Operational must be enabled to perform this operation.')

    # (0x80300111) The Event Log channel Microsoft-Windows-TaskScheduler must be enabled to perform this operation.
    PLA_E_TASKSCHED_CHANNEL_NOT_ENABLED = HResultCode.new('PLA_E_TASKSCHED_CHANNEL_NOT_ENABLED', 0x80300111, 'The Event Log channel Microsoft-Windows-TaskScheduler must be enabled to perform this operation.')

    # (0x80310000) The volume must be unlocked before it can be used.
    FVE_E_LOCKED_VOLUME = HResultCode.new('FVE_E_LOCKED_VOLUME', 0x80310000, 'The volume must be unlocked before it can be used.')

    # (0x80310001) The volume is fully decrypted and no key is available.
    FVE_E_NOT_ENCRYPTED = HResultCode.new('FVE_E_NOT_ENCRYPTED', 0x80310001, 'The volume is fully decrypted and no key is available.')

    # (0x80310002) The firmware does not support using a TPM during boot.
    FVE_E_NO_TPM_BIOS = HResultCode.new('FVE_E_NO_TPM_BIOS', 0x80310002, 'The firmware does not support using a TPM during boot.')

    # (0x80310003) The firmware does not use a TPM to perform initial program load (IPL) measurement.
    FVE_E_NO_MBR_METRIC = HResultCode.new('FVE_E_NO_MBR_METRIC', 0x80310003, 'The firmware does not use a TPM to perform initial program load (IPL) measurement.')

    # (0x80310004) The master boot record (MBR) is not TPM-aware.
    FVE_E_NO_BOOTSECTOR_METRIC = HResultCode.new('FVE_E_NO_BOOTSECTOR_METRIC', 0x80310004, 'The master boot record (MBR) is not TPM-aware.')

    # (0x80310005) The BOOTMGR is not being measured by the TPM.
    FVE_E_NO_BOOTMGR_METRIC = HResultCode.new('FVE_E_NO_BOOTMGR_METRIC', 0x80310005, 'The BOOTMGR is not being measured by the TPM.')

    # (0x80310006) The BOOTMGR component does not perform expected TPM measurements.
    FVE_E_WRONG_BOOTMGR = HResultCode.new('FVE_E_WRONG_BOOTMGR', 0x80310006, 'The BOOTMGR component does not perform expected TPM measurements.')

    # (0x80310007) No secure key protection mechanism has been defined.
    FVE_E_SECURE_KEY_REQUIRED = HResultCode.new('FVE_E_SECURE_KEY_REQUIRED', 0x80310007, 'No secure key protection mechanism has been defined.')

    # (0x80310008) This volume has not been provisioned for encryption.
    FVE_E_NOT_ACTIVATED = HResultCode.new('FVE_E_NOT_ACTIVATED', 0x80310008, 'This volume has not been provisioned for encryption.')

    # (0x80310009) Requested action was denied by the full-volume encryption (FVE) control engine.
    FVE_E_ACTION_NOT_ALLOWED = HResultCode.new('FVE_E_ACTION_NOT_ALLOWED', 0x80310009, 'Requested action was denied by the full-volume encryption (FVE) control engine.')

    # (0x8031000a) The Active Directory forest does not contain the required attributes and classes to host FVE or TPM information.
    FVE_E_AD_SCHEMA_NOT_INSTALLED = HResultCode.new('FVE_E_AD_SCHEMA_NOT_INSTALLED', 0x8031000a, 'The Active Directory forest does not contain the required attributes and classes to host FVE or TPM information.')

    # (0x8031000b) The type of data obtained from Active Directory was not expected.
    FVE_E_AD_INVALID_DATATYPE = HResultCode.new('FVE_E_AD_INVALID_DATATYPE', 0x8031000b, 'The type of data obtained from Active Directory was not expected.')

    # (0x8031000c) The size of the data obtained from Active Directory was not expected.
    FVE_E_AD_INVALID_DATASIZE = HResultCode.new('FVE_E_AD_INVALID_DATASIZE', 0x8031000c, 'The size of the data obtained from Active Directory was not expected.')

    # (0x8031000d) The attribute read from Active Directory has no (zero) values.
    FVE_E_AD_NO_VALUES = HResultCode.new('FVE_E_AD_NO_VALUES', 0x8031000d, 'The attribute read from Active Directory has no (zero) values.')

    # (0x8031000e) The attribute was not set.
    FVE_E_AD_ATTR_NOT_SET = HResultCode.new('FVE_E_AD_ATTR_NOT_SET', 0x8031000e, 'The attribute was not set.')

    # (0x8031000f) The specified GUID could not be found.
    FVE_E_AD_GUID_NOT_FOUND = HResultCode.new('FVE_E_AD_GUID_NOT_FOUND', 0x8031000f, 'The specified GUID could not be found.')

    # (0x80310010) The control block for the encrypted volume is not valid.
    FVE_E_BAD_INFORMATION = HResultCode.new('FVE_E_BAD_INFORMATION', 0x80310010, 'The control block for the encrypted volume is not valid.')

    # (0x80310011) Not enough free space remaining on volume to allow encryption.
    FVE_E_TOO_SMALL = HResultCode.new('FVE_E_TOO_SMALL', 0x80310011, 'Not enough free space remaining on volume to allow encryption.')

    # (0x80310012) The volume cannot be encrypted because it is required to boot the operating system.
    FVE_E_SYSTEM_VOLUME = HResultCode.new('FVE_E_SYSTEM_VOLUME', 0x80310012, 'The volume cannot be encrypted because it is required to boot the operating system.')

    # (0x80310013) The volume cannot be encrypted because the file system is not supported.
    FVE_E_FAILED_WRONG_FS = HResultCode.new('FVE_E_FAILED_WRONG_FS', 0x80310013, 'The volume cannot be encrypted because the file system is not supported.')

    # (0x80310014) The file system is inconsistent. Run CHKDSK.
    FVE_E_FAILED_BAD_FS = HResultCode.new('FVE_E_FAILED_BAD_FS', 0x80310014, 'The file system is inconsistent. Run CHKDSK.')

    # (0x80310015) This volume cannot be encrypted.
    FVE_E_NOT_SUPPORTED = HResultCode.new('FVE_E_NOT_SUPPORTED', 0x80310015, 'This volume cannot be encrypted.')

    # (0x80310016) Data supplied is malformed.
    FVE_E_BAD_DATA = HResultCode.new('FVE_E_BAD_DATA', 0x80310016, 'Data supplied is malformed.')

    # (0x80310017) Volume is not bound to the system.
    FVE_E_VOLUME_NOT_BOUND = HResultCode.new('FVE_E_VOLUME_NOT_BOUND', 0x80310017, 'Volume is not bound to the system.')

    # (0x80310018) TPM must be owned before a volume can be bound to it.
    FVE_E_TPM_NOT_OWNED = HResultCode.new('FVE_E_TPM_NOT_OWNED', 0x80310018, 'TPM must be owned before a volume can be bound to it.')

    # (0x80310019) The volume specified is not a data volume.
    FVE_E_NOT_DATA_VOLUME = HResultCode.new('FVE_E_NOT_DATA_VOLUME', 0x80310019, 'The volume specified is not a data volume.')

    # (0x8031001a) The buffer supplied to a function was insufficient to contain the returned data.
    FVE_E_AD_INSUFFICIENT_BUFFER = HResultCode.new('FVE_E_AD_INSUFFICIENT_BUFFER', 0x8031001a, 'The buffer supplied to a function was insufficient to contain the returned data.')

    # (0x8031001b) A read operation failed while converting the volume.
    FVE_E_CONV_READ = HResultCode.new('FVE_E_CONV_READ', 0x8031001b, 'A read operation failed while converting the volume.')

    # (0x8031001c) A write operation failed while converting the volume.
    FVE_E_CONV_WRITE = HResultCode.new('FVE_E_CONV_WRITE', 0x8031001c, 'A write operation failed while converting the volume.')

    # (0x8031001d) One or more key protection mechanisms are required for this volume.
    FVE_E_KEY_REQUIRED = HResultCode.new('FVE_E_KEY_REQUIRED', 0x8031001d, 'One or more key protection mechanisms are required for this volume.')

    # (0x8031001e) Cluster configurations are not supported.
    FVE_E_CLUSTERING_NOT_SUPPORTED = HResultCode.new('FVE_E_CLUSTERING_NOT_SUPPORTED', 0x8031001e, 'Cluster configurations are not supported.')

    # (0x8031001f) The volume is already bound to the system.
    FVE_E_VOLUME_BOUND_ALREADY = HResultCode.new('FVE_E_VOLUME_BOUND_ALREADY', 0x8031001f, 'The volume is already bound to the system.')

    # (0x80310020) The boot OS volume is not being protected via FVE.
    FVE_E_OS_NOT_PROTECTED = HResultCode.new('FVE_E_OS_NOT_PROTECTED', 0x80310020, 'The boot OS volume is not being protected via FVE.')

    # (0x80310021) All protection mechanisms are effectively disabled (clear key exists).
    FVE_E_PROTECTION_DISABLED = HResultCode.new('FVE_E_PROTECTION_DISABLED', 0x80310021, 'All protection mechanisms are effectively disabled (clear key exists).')

    # (0x80310022) A recovery key protection mechanism is required.
    FVE_E_RECOVERY_KEY_REQUIRED = HResultCode.new('FVE_E_RECOVERY_KEY_REQUIRED', 0x80310022, 'A recovery key protection mechanism is required.')

    # (0x80310023) This volume cannot be bound to a TPM.
    FVE_E_FOREIGN_VOLUME = HResultCode.new('FVE_E_FOREIGN_VOLUME', 0x80310023, 'This volume cannot be bound to a TPM.')

    # (0x80310024) The control block for the encrypted volume was updated by another thread. Try again.
    FVE_E_OVERLAPPED_UPDATE = HResultCode.new('FVE_E_OVERLAPPED_UPDATE', 0x80310024, 'The control block for the encrypted volume was updated by another thread. Try again.')

    # (0x80310025) The SRK authentication of the TPM is not zero and, therefore, is not compatible.
    FVE_E_TPM_SRK_AUTH_NOT_ZERO = HResultCode.new('FVE_E_TPM_SRK_AUTH_NOT_ZERO', 0x80310025, 'The SRK authentication of the TPM is not zero and, therefore, is not compatible.')

    # (0x80310026) The volume encryption algorithm cannot be used on this sector size.
    FVE_E_FAILED_SECTOR_SIZE = HResultCode.new('FVE_E_FAILED_SECTOR_SIZE', 0x80310026, 'The volume encryption algorithm cannot be used on this sector size.')

    # (0x80310027) BitLocker recovery authentication failed.
    FVE_E_FAILED_AUTHENTICATION = HResultCode.new('FVE_E_FAILED_AUTHENTICATION', 0x80310027, 'BitLocker recovery authentication failed.')

    # (0x80310028) The volume specified is not the boot OS volume.
    FVE_E_NOT_OS_VOLUME = HResultCode.new('FVE_E_NOT_OS_VOLUME', 0x80310028, 'The volume specified is not the boot OS volume.')

    # (0x80310029) Auto-unlock information for data volumes is present on the boot OS volume.
    FVE_E_AUTOUNLOCK_ENABLED = HResultCode.new('FVE_E_AUTOUNLOCK_ENABLED', 0x80310029, 'Auto-unlock information for data volumes is present on the boot OS volume.')

    # (0x8031002a) The system partition boot sector does not perform TPM measurements.
    FVE_E_WRONG_BOOTSECTOR = HResultCode.new('FVE_E_WRONG_BOOTSECTOR', 0x8031002a, 'The system partition boot sector does not perform TPM measurements.')

    # (0x8031002b) The system partition file system must be NTFS.
    FVE_E_WRONG_SYSTEM_FS = HResultCode.new('FVE_E_WRONG_SYSTEM_FS', 0x8031002b, 'The system partition file system must be NTFS.')

    # (0x8031002c) Group policy requires a recovery password before encryption can begin.
    FVE_E_POLICY_PASSWORD_REQUIRED = HResultCode.new('FVE_E_POLICY_PASSWORD_REQUIRED', 0x8031002c, 'Group policy requires a recovery password before encryption can begin.')

    # (0x8031002d) The volume encryption algorithm and key cannot be set on an encrypted volume.
    FVE_E_CANNOT_SET_FVEK_ENCRYPTED = HResultCode.new('FVE_E_CANNOT_SET_FVEK_ENCRYPTED', 0x8031002d, 'The volume encryption algorithm and key cannot be set on an encrypted volume.')

    # (0x8031002e) A key must be specified before encryption can begin.
    FVE_E_CANNOT_ENCRYPT_NO_KEY = HResultCode.new('FVE_E_CANNOT_ENCRYPT_NO_KEY', 0x8031002e, 'A key must be specified before encryption can begin.')

    # (0x80310030) A bootable CD/DVD is in the system. Remove the CD/DVD and reboot the system.
    FVE_E_BOOTABLE_CDDVD = HResultCode.new('FVE_E_BOOTABLE_CDDVD', 0x80310030, 'A bootable CD/DVD is in the system. Remove the CD/DVD and reboot the system.')

    # (0x80310031) An instance of this key protector already exists on the volume.
    FVE_E_PROTECTOR_EXISTS = HResultCode.new('FVE_E_PROTECTOR_EXISTS', 0x80310031, 'An instance of this key protector already exists on the volume.')

    # (0x80310032) The file cannot be saved to a relative path.
    FVE_E_RELATIVE_PATH = HResultCode.new('FVE_E_RELATIVE_PATH', 0x80310032, 'The file cannot be saved to a relative path.')

    # (0x80320001) The callout does not exist.
    FWP_E_CALLOUT_NOT_FOUND = HResultCode.new('FWP_E_CALLOUT_NOT_FOUND', 0x80320001, 'The callout does not exist.')

    # (0x80320002) The filter condition does not exist.
    FWP_E_CONDITION_NOT_FOUND = HResultCode.new('FWP_E_CONDITION_NOT_FOUND', 0x80320002, 'The filter condition does not exist.')

    # (0x80320003) The filter does not exist.
    FWP_E_FILTER_NOT_FOUND = HResultCode.new('FWP_E_FILTER_NOT_FOUND', 0x80320003, 'The filter does not exist.')

    # (0x80320004) The layer does not exist.
    FWP_E_LAYER_NOT_FOUND = HResultCode.new('FWP_E_LAYER_NOT_FOUND', 0x80320004, 'The layer does not exist.')

    # (0x80320005) The provider does not exist.
    FWP_E_PROVIDER_NOT_FOUND = HResultCode.new('FWP_E_PROVIDER_NOT_FOUND', 0x80320005, 'The provider does not exist.')

    # (0x80320006) The provider context does not exist.
    FWP_E_PROVIDER_CONTEXT_NOT_FOUND = HResultCode.new('FWP_E_PROVIDER_CONTEXT_NOT_FOUND', 0x80320006, 'The provider context does not exist.')

    # (0x80320007) The sublayer does not exist.
    FWP_E_SUBLAYER_NOT_FOUND = HResultCode.new('FWP_E_SUBLAYER_NOT_FOUND', 0x80320007, 'The sublayer does not exist.')

    # (0x80320008) The object does not exist.
    FWP_E_NOT_FOUND = HResultCode.new('FWP_E_NOT_FOUND', 0x80320008, 'The object does not exist.')

    # (0x80320009) An object with that GUID or LUID already exists.
    FWP_E_ALREADY_EXISTS = HResultCode.new('FWP_E_ALREADY_EXISTS', 0x80320009, 'An object with that GUID or LUID already exists.')

    # (0x8032000a) The object is referenced by other objects and, therefore, cannot be deleted.
    FWP_E_IN_USE = HResultCode.new('FWP_E_IN_USE', 0x8032000a, 'The object is referenced by other objects and, therefore, cannot be deleted.')

    # (0x8032000b) The call is not allowed from within a dynamic session.
    FWP_E_DYNAMIC_SESSION_IN_PROGRESS = HResultCode.new('FWP_E_DYNAMIC_SESSION_IN_PROGRESS', 0x8032000b, 'The call is not allowed from within a dynamic session.')

    # (0x8032000c) The call was made from the wrong session and, therefore, cannot be completed.
    FWP_E_WRONG_SESSION = HResultCode.new('FWP_E_WRONG_SESSION', 0x8032000c, 'The call was made from the wrong session and, therefore, cannot be completed.')

    # (0x8032000d) The call must be made from within an explicit transaction.
    FWP_E_NO_TXN_IN_PROGRESS = HResultCode.new('FWP_E_NO_TXN_IN_PROGRESS', 0x8032000d, 'The call must be made from within an explicit transaction.')

    # (0x8032000e) The call is not allowed from within an explicit transaction.
    FWP_E_TXN_IN_PROGRESS = HResultCode.new('FWP_E_TXN_IN_PROGRESS', 0x8032000e, 'The call is not allowed from within an explicit transaction.')

    # (0x8032000f) The explicit transaction has been forcibly canceled.
    FWP_E_TXN_ABORTED = HResultCode.new('FWP_E_TXN_ABORTED', 0x8032000f, 'The explicit transaction has been forcibly canceled.')

    # (0x80320010) The session has been canceled.
    FWP_E_SESSION_ABORTED = HResultCode.new('FWP_E_SESSION_ABORTED', 0x80320010, 'The session has been canceled.')

    # (0x80320011) The call is not allowed from within a read-only transaction.
    FWP_E_INCOMPATIBLE_TXN = HResultCode.new('FWP_E_INCOMPATIBLE_TXN', 0x80320011, 'The call is not allowed from within a read-only transaction.')

    # (0x80320012) The call timed out while waiting to acquire the transaction lock.
    FWP_E_TIMEOUT = HResultCode.new('FWP_E_TIMEOUT', 0x80320012, 'The call timed out while waiting to acquire the transaction lock.')

    # (0x80320013) Collection of network diagnostic events is disabled.
    FWP_E_NET_EVENTS_DISABLED = HResultCode.new('FWP_E_NET_EVENTS_DISABLED', 0x80320013, 'Collection of network diagnostic events is disabled.')

    # (0x80320014) The operation is not supported by the specified layer.
    FWP_E_INCOMPATIBLE_LAYER = HResultCode.new('FWP_E_INCOMPATIBLE_LAYER', 0x80320014, 'The operation is not supported by the specified layer.')

    # (0x80320015) The call is allowed for kernel-mode callers only.
    FWP_E_KM_CLIENTS_ONLY = HResultCode.new('FWP_E_KM_CLIENTS_ONLY', 0x80320015, 'The call is allowed for kernel-mode callers only.')

    # (0x80320016) The call tried to associate two objects with incompatible lifetimes.
    FWP_E_LIFETIME_MISMATCH = HResultCode.new('FWP_E_LIFETIME_MISMATCH', 0x80320016, 'The call tried to associate two objects with incompatible lifetimes.')

    # (0x80320017) The object is built in and, therefore, cannot be deleted.
    FWP_E_BUILTIN_OBJECT = HResultCode.new('FWP_E_BUILTIN_OBJECT', 0x80320017, 'The object is built in and, therefore, cannot be deleted.')

    # (0x80320018) The maximum number of boot-time filters has been reached.
    FWP_E_TOO_MANY_BOOTTIME_FILTERS = HResultCode.new('FWP_E_TOO_MANY_BOOTTIME_FILTERS', 0x80320018, 'The maximum number of boot-time filters has been reached.')

    # (0x80320019) A notification could not be delivered because a message queue is at its maximum capacity.
    FWP_E_NOTIFICATION_DROPPED = HResultCode.new('FWP_E_NOTIFICATION_DROPPED', 0x80320019, 'A notification could not be delivered because a message queue is at its maximum capacity.')

    # (0x8032001a) The traffic parameters do not match those for the security association context.
    FWP_E_TRAFFIC_MISMATCH = HResultCode.new('FWP_E_TRAFFIC_MISMATCH', 0x8032001a, 'The traffic parameters do not match those for the security association context.')

    # (0x8032001b) The call is not allowed for the current security association state.
    FWP_E_INCOMPATIBLE_SA_STATE = HResultCode.new('FWP_E_INCOMPATIBLE_SA_STATE', 0x8032001b, 'The call is not allowed for the current security association state.')

    # (0x8032001c) A required pointer is null.
    FWP_E_NULL_POINTER = HResultCode.new('FWP_E_NULL_POINTER', 0x8032001c, 'A required pointer is null.')

    # (0x8032001d) An enumerator is not valid.
    FWP_E_INVALID_ENUMERATOR = HResultCode.new('FWP_E_INVALID_ENUMERATOR', 0x8032001d, 'An enumerator is not valid.')

    # (0x8032001e) The flags field contains an invalid value.
    FWP_E_INVALID_FLAGS = HResultCode.new('FWP_E_INVALID_FLAGS', 0x8032001e, 'The flags field contains an invalid value.')

    # (0x8032001f) A network mask is not valid.
    FWP_E_INVALID_NET_MASK = HResultCode.new('FWP_E_INVALID_NET_MASK', 0x8032001f, 'A network mask is not valid.')

    # (0x80320020) An FWP_RANGE is not valid.
    FWP_E_INVALID_RANGE = HResultCode.new('FWP_E_INVALID_RANGE', 0x80320020, 'An FWP_RANGE is not valid.')

    # (0x80320021) The time interval is not valid.
    FWP_E_INVALID_INTERVAL = HResultCode.new('FWP_E_INVALID_INTERVAL', 0x80320021, 'The time interval is not valid.')

    # (0x80320022) An array that must contain at least one element that is zero-length.
    FWP_E_ZERO_LENGTH_ARRAY = HResultCode.new('FWP_E_ZERO_LENGTH_ARRAY', 0x80320022, 'An array that must contain at least one element that is zero-length.')

    # (0x80320023) The displayData.name field cannot be null.
    FWP_E_NULL_DISPLAY_NAME = HResultCode.new('FWP_E_NULL_DISPLAY_NAME', 0x80320023, 'The displayData.name field cannot be null.')

    # (0x80320024) The action type is not one of the allowed action types for a filter.
    FWP_E_INVALID_ACTION_TYPE = HResultCode.new('FWP_E_INVALID_ACTION_TYPE', 0x80320024, 'The action type is not one of the allowed action types for a filter.')

    # (0x80320025) The filter weight is not valid.
    FWP_E_INVALID_WEIGHT = HResultCode.new('FWP_E_INVALID_WEIGHT', 0x80320025, 'The filter weight is not valid.')

    # (0x80320026) A filter condition contains a match type that is not compatible with the operands.
    FWP_E_MATCH_TYPE_MISMATCH = HResultCode.new('FWP_E_MATCH_TYPE_MISMATCH', 0x80320026, 'A filter condition contains a match type that is not compatible with the operands.')

    # (0x80320027) An FWP_VALUE or FWPM_CONDITION_VALUE is of the wrong type.
    FWP_E_TYPE_MISMATCH = HResultCode.new('FWP_E_TYPE_MISMATCH', 0x80320027, 'An FWP_VALUE or FWPM_CONDITION_VALUE is of the wrong type.')

    # (0x80320028) An integer value is outside the allowed range.
    FWP_E_OUT_OF_BOUNDS = HResultCode.new('FWP_E_OUT_OF_BOUNDS', 0x80320028, 'An integer value is outside the allowed range.')

    # (0x80320029) A reserved field is nonzero.
    FWP_E_RESERVED = HResultCode.new('FWP_E_RESERVED', 0x80320029, 'A reserved field is nonzero.')

    # (0x8032002a) A filter cannot contain multiple conditions operating on a single field.
    FWP_E_DUPLICATE_CONDITION = HResultCode.new('FWP_E_DUPLICATE_CONDITION', 0x8032002a, 'A filter cannot contain multiple conditions operating on a single field.')

    # (0x8032002b) A policy cannot contain the same keying module more than once.
    FWP_E_DUPLICATE_KEYMOD = HResultCode.new('FWP_E_DUPLICATE_KEYMOD', 0x8032002b, 'A policy cannot contain the same keying module more than once.')

    # (0x8032002c) The action type is not compatible with the layer.
    FWP_E_ACTION_INCOMPATIBLE_WITH_LAYER = HResultCode.new('FWP_E_ACTION_INCOMPATIBLE_WITH_LAYER', 0x8032002c, 'The action type is not compatible with the layer.')

    # (0x8032002d) The action type is not compatible with the sublayer.
    FWP_E_ACTION_INCOMPATIBLE_WITH_SUBLAYER = HResultCode.new('FWP_E_ACTION_INCOMPATIBLE_WITH_SUBLAYER', 0x8032002d, 'The action type is not compatible with the sublayer.')

    # (0x8032002e) The raw context or the provider context is not compatible with the layer.
    FWP_E_CONTEXT_INCOMPATIBLE_WITH_LAYER = HResultCode.new('FWP_E_CONTEXT_INCOMPATIBLE_WITH_LAYER', 0x8032002e, 'The raw context or the provider context is not compatible with the layer.')

    # (0x8032002f) The raw context or the provider context is not compatible with the callout.
    FWP_E_CONTEXT_INCOMPATIBLE_WITH_CALLOUT = HResultCode.new('FWP_E_CONTEXT_INCOMPATIBLE_WITH_CALLOUT', 0x8032002f, 'The raw context or the provider context is not compatible with the callout.')

    # (0x80320030) The authentication method is not compatible with the policy type.
    FWP_E_INCOMPATIBLE_AUTH_METHOD = HResultCode.new('FWP_E_INCOMPATIBLE_AUTH_METHOD', 0x80320030, 'The authentication method is not compatible with the policy type.')

    # (0x80320031) The Diffie-Hellman group is not compatible with the policy type.
    FWP_E_INCOMPATIBLE_DH_GROUP = HResultCode.new('FWP_E_INCOMPATIBLE_DH_GROUP', 0x80320031, 'The Diffie-Hellman group is not compatible with the policy type.')

    # (0x80320032) An Internet Key Exchange (IKE) policy cannot contain an Extended Mode policy.
    FWP_E_EM_NOT_SUPPORTED = HResultCode.new('FWP_E_EM_NOT_SUPPORTED', 0x80320032, 'An Internet Key Exchange (IKE) policy cannot contain an Extended Mode policy.')

    # (0x80320033) The enumeration template or subscription will never match any objects.
    FWP_E_NEVER_MATCH = HResultCode.new('FWP_E_NEVER_MATCH', 0x80320033, 'The enumeration template or subscription will never match any objects.')

    # (0x80320034) The provider context is of the wrong type.
    FWP_E_PROVIDER_CONTEXT_MISMATCH = HResultCode.new('FWP_E_PROVIDER_CONTEXT_MISMATCH', 0x80320034, 'The provider context is of the wrong type.')

    # (0x80320035) The parameter is incorrect.
    FWP_E_INVALID_PARAMETER = HResultCode.new('FWP_E_INVALID_PARAMETER', 0x80320035, 'The parameter is incorrect.')

    # (0x80320036) The maximum number of sublayers has been reached.
    FWP_E_TOO_MANY_SUBLAYERS = HResultCode.new('FWP_E_TOO_MANY_SUBLAYERS', 0x80320036, 'The maximum number of sublayers has been reached.')

    # (0x80320037) The notification function for a callout returned an error.
    FWP_E_CALLOUT_NOTIFICATION_FAILED = HResultCode.new('FWP_E_CALLOUT_NOTIFICATION_FAILED', 0x80320037, 'The notification function for a callout returned an error.')

    # (0x80320038) The IPsec authentication configuration is not compatible with the authentication type.
    FWP_E_INCOMPATIBLE_AUTH_CONFIG = HResultCode.new('FWP_E_INCOMPATIBLE_AUTH_CONFIG', 0x80320038, 'The IPsec authentication configuration is not compatible with the authentication type.')

    # (0x80320039) The IPsec cipher configuration is not compatible with the cipher type.
    FWP_E_INCOMPATIBLE_CIPHER_CONFIG = HResultCode.new('FWP_E_INCOMPATIBLE_CIPHER_CONFIG', 0x80320039, 'The IPsec cipher configuration is not compatible with the cipher type.')

    # (0x80340002) The binding to the network interface is being closed.
    ERROR_NDIS_INTERFACE_CLOSING = HResultCode.new('ERROR_NDIS_INTERFACE_CLOSING', 0x80340002, 'The binding to the network interface is being closed.')

    # (0x80340004) An invalid version was specified.
    ERROR_NDIS_BAD_VERSION = HResultCode.new('ERROR_NDIS_BAD_VERSION', 0x80340004, 'An invalid version was specified.')

    # (0x80340005) An invalid characteristics table was used.
    ERROR_NDIS_BAD_CHARACTERISTICS = HResultCode.new('ERROR_NDIS_BAD_CHARACTERISTICS', 0x80340005, 'An invalid characteristics table was used.')

    # (0x80340006) Failed to find the network interface, or the network interface is not ready.
    ERROR_NDIS_ADAPTER_NOT_FOUND = HResultCode.new('ERROR_NDIS_ADAPTER_NOT_FOUND', 0x80340006, 'Failed to find the network interface, or the network interface is not ready.')

    # (0x80340007) Failed to open the network interface.
    ERROR_NDIS_OPEN_FAILED = HResultCode.new('ERROR_NDIS_OPEN_FAILED', 0x80340007, 'Failed to open the network interface.')

    # (0x80340008) The network interface has encountered an internal unrecoverable failure.
    ERROR_NDIS_DEVICE_FAILED = HResultCode.new('ERROR_NDIS_DEVICE_FAILED', 0x80340008, 'The network interface has encountered an internal unrecoverable failure.')

    # (0x80340009) The multicast list on the network interface is full.
    ERROR_NDIS_MULTICAST_FULL = HResultCode.new('ERROR_NDIS_MULTICAST_FULL', 0x80340009, 'The multicast list on the network interface is full.')

    # (0x8034000a) An attempt was made to add a duplicate multicast address to the list.
    ERROR_NDIS_MULTICAST_EXISTS = HResultCode.new('ERROR_NDIS_MULTICAST_EXISTS', 0x8034000a, 'An attempt was made to add a duplicate multicast address to the list.')

    # (0x8034000b) At attempt was made to remove a multicast address that was never added.
    ERROR_NDIS_MULTICAST_NOT_FOUND = HResultCode.new('ERROR_NDIS_MULTICAST_NOT_FOUND', 0x8034000b, 'At attempt was made to remove a multicast address that was never added.')

    # (0x8034000c) The network interface aborted the request.
    ERROR_NDIS_REQUEST_ABORTED = HResultCode.new('ERROR_NDIS_REQUEST_ABORTED', 0x8034000c, 'The network interface aborted the request.')

    # (0x8034000d) The network interface cannot process the request because it is being reset.
    ERROR_NDIS_RESET_IN_PROGRESS = HResultCode.new('ERROR_NDIS_RESET_IN_PROGRESS', 0x8034000d, 'The network interface cannot process the request because it is being reset.')

    # (0x8034000f) An attempt was made to send an invalid packet on a network interface.
    ERROR_NDIS_INVALID_PACKET = HResultCode.new('ERROR_NDIS_INVALID_PACKET', 0x8034000f, 'An attempt was made to send an invalid packet on a network interface.')

    # (0x80340010) The specified request is not a valid operation for the target device.
    ERROR_NDIS_INVALID_DEVICE_REQUEST = HResultCode.new('ERROR_NDIS_INVALID_DEVICE_REQUEST', 0x80340010, 'The specified request is not a valid operation for the target device.')

    # (0x80340011) The network interface is not ready to complete this operation.
    ERROR_NDIS_ADAPTER_NOT_READY = HResultCode.new('ERROR_NDIS_ADAPTER_NOT_READY', 0x80340011, 'The network interface is not ready to complete this operation.')

    # (0x80340014) The length of the buffer submitted for this operation is not valid.
    ERROR_NDIS_INVALID_LENGTH = HResultCode.new('ERROR_NDIS_INVALID_LENGTH', 0x80340014, 'The length of the buffer submitted for this operation is not valid.')

    # (0x80340015) The data used for this operation is not valid.
    ERROR_NDIS_INVALID_DATA = HResultCode.new('ERROR_NDIS_INVALID_DATA', 0x80340015, 'The data used for this operation is not valid.')

    # (0x80340016) The length of the buffer submitted for this operation is too small.
    ERROR_NDIS_BUFFER_TOO_SHORT = HResultCode.new('ERROR_NDIS_BUFFER_TOO_SHORT', 0x80340016, 'The length of the buffer submitted for this operation is too small.')

    # (0x80340017) The network interface does not support this OID.
    ERROR_NDIS_INVALID_OID = HResultCode.new('ERROR_NDIS_INVALID_OID', 0x80340017, 'The network interface does not support this OID.')

    # (0x80340018) The network interface has been removed.
    ERROR_NDIS_ADAPTER_REMOVED = HResultCode.new('ERROR_NDIS_ADAPTER_REMOVED', 0x80340018, 'The network interface has been removed.')

    # (0x80340019) The network interface does not support this media type.
    ERROR_NDIS_UNSUPPORTED_MEDIA = HResultCode.new('ERROR_NDIS_UNSUPPORTED_MEDIA', 0x80340019, 'The network interface does not support this media type.')

    # (0x8034001a) An attempt was made to remove a token ring group address that is in use by other components.
    ERROR_NDIS_GROUP_ADDRESS_IN_USE = HResultCode.new('ERROR_NDIS_GROUP_ADDRESS_IN_USE', 0x8034001a, 'An attempt was made to remove a token ring group address that is in use by other components.')

    # (0x8034001b) An attempt was made to map a file that cannot be found.
    ERROR_NDIS_FILE_NOT_FOUND = HResultCode.new('ERROR_NDIS_FILE_NOT_FOUND', 0x8034001b, 'An attempt was made to map a file that cannot be found.')

    # (0x8034001c) An error occurred while the NDIS tried to map the file.
    ERROR_NDIS_ERROR_READING_FILE = HResultCode.new('ERROR_NDIS_ERROR_READING_FILE', 0x8034001c, 'An error occurred while the NDIS tried to map the file.')

    # (0x8034001d) An attempt was made to map a file that is already mapped.
    ERROR_NDIS_ALREADY_MAPPED = HResultCode.new('ERROR_NDIS_ALREADY_MAPPED', 0x8034001d, 'An attempt was made to map a file that is already mapped.')

    # (0x8034001e) An attempt to allocate a hardware resource failed because the resource is used by another component.
    ERROR_NDIS_RESOURCE_CONFLICT = HResultCode.new('ERROR_NDIS_RESOURCE_CONFLICT', 0x8034001e, 'An attempt to allocate a hardware resource failed because the resource is used by another component.')

    # (0x8034001f) The I/O operation failed because network media is disconnected or the wireless access point is out of range.
    ERROR_NDIS_MEDIA_DISCONNECTED = HResultCode.new('ERROR_NDIS_MEDIA_DISCONNECTED', 0x8034001f, 'The I/O operation failed because network media is disconnected or the wireless access point is out of range.')

    # (0x80340022) The network address used in the request is invalid.
    ERROR_NDIS_INVALID_ADDRESS = HResultCode.new('ERROR_NDIS_INVALID_ADDRESS', 0x80340022, 'The network address used in the request is invalid.')

    # (0x8034002a) The offload operation on the network interface has been paused.
    ERROR_NDIS_PAUSED = HResultCode.new('ERROR_NDIS_PAUSED', 0x8034002a, 'The offload operation on the network interface has been paused.')

    # (0x8034002b) The network interface was not found.
    ERROR_NDIS_INTERFACE_NOT_FOUND = HResultCode.new('ERROR_NDIS_INTERFACE_NOT_FOUND', 0x8034002b, 'The network interface was not found.')

    # (0x8034002c) The revision number specified in the structure is not supported.
    ERROR_NDIS_UNSUPPORTED_REVISION = HResultCode.new('ERROR_NDIS_UNSUPPORTED_REVISION', 0x8034002c, 'The revision number specified in the structure is not supported.')

    # (0x8034002d) The specified port does not exist on this network interface.
    ERROR_NDIS_INVALID_PORT = HResultCode.new('ERROR_NDIS_INVALID_PORT', 0x8034002d, 'The specified port does not exist on this network interface.')

    # (0x8034002e) The current state of the specified port on this network interface does not support the requested operation.
    ERROR_NDIS_INVALID_PORT_STATE = HResultCode.new('ERROR_NDIS_INVALID_PORT_STATE', 0x8034002e, 'The current state of the specified port on this network interface does not support the requested operation.')

    # (0x803400bb) The network interface does not support this request.
    ERROR_NDIS_NOT_SUPPORTED = HResultCode.new('ERROR_NDIS_NOT_SUPPORTED', 0x803400bb, 'The network interface does not support this request.')

    # (0x80342000) The wireless local area network (LAN) interface is in auto-configuration mode and does not support the requested parameter change operation.
    ERROR_NDIS_DOT11_AUTO_CONFIG_ENABLED = HResultCode.new('ERROR_NDIS_DOT11_AUTO_CONFIG_ENABLED', 0x80342000, 'The wireless local area network (LAN) interface is in auto-configuration mode and does not support the requested parameter change operation.')

    # (0x80342001) The wireless LAN interface is busy and cannot perform the requested operation.
    ERROR_NDIS_DOT11_MEDIA_IN_USE = HResultCode.new('ERROR_NDIS_DOT11_MEDIA_IN_USE', 0x80342001, 'The wireless LAN interface is busy and cannot perform the requested operation.')

    # (0x80342002) The wireless LAN interface is shutting down and does not support the requested operation.
    ERROR_NDIS_DOT11_POWER_STATE_INVALID = HResultCode.new('ERROR_NDIS_DOT11_POWER_STATE_INVALID', 0x80342002, 'The wireless LAN interface is shutting down and does not support the requested operation.')

    # (0x8dead01b) A requested object was not found.
    TRK_E_NOT_FOUND = HResultCode.new('TRK_E_NOT_FOUND', 0x8dead01b, 'A requested object was not found.')

    # (0x8dead01c) The server received a CREATE_VOLUME subrequest of a SYNC_VOLUMES request, but the ServerVolumeTable size limit for the RequestMachine has already been reached.
    TRK_E_VOLUME_QUOTA_EXCEEDED = HResultCode.new('TRK_E_VOLUME_QUOTA_EXCEEDED', 0x8dead01c, 'The server received a CREATE_VOLUME subrequest of a SYNC_VOLUMES request, but the ServerVolumeTable size limit for the RequestMachine has already been reached.')

    # (0x8dead01e) The server is busy, and the client should retry the request at a later time.
    TRK_SERVER_TOO_BUSY = HResultCode.new('TRK_SERVER_TOO_BUSY', 0x8dead01e, 'The server is busy, and the client should retry the request at a later time.')

    # (0xc0090001) The specified event is currently not being audited.
    ERROR_AUDITING_DISABLED = HResultCode.new('ERROR_AUDITING_DISABLED', 0xc0090001, 'The specified event is currently not being audited.')

    # (0xc0090002) The SID filtering operation removed all SIDs.
    ERROR_ALL_SIDS_FILTERED = HResultCode.new('ERROR_ALL_SIDS_FILTERED', 0xc0090002, 'The SID filtering operation removed all SIDs.')

    # (0xc0090003) Business rule scripts are disabled for the calling application.
    ERROR_BIZRULES_NOT_ENABLED = HResultCode.new('ERROR_BIZRULES_NOT_ENABLED', 0xc0090003, 'Business rule scripts are disabled for the calling application.')

    # (0xc00d0005) There is no connection established with the Windows Media server. The operation failed.
    NS_E_NOCONNECTION = HResultCode.new('NS_E_NOCONNECTION', 0xc00d0005, 'There is no connection established with the Windows Media server. The operation failed.')

    # (0xc00d0006) Unable to establish a connection to the server.
    NS_E_CANNOTCONNECT = HResultCode.new('NS_E_CANNOTCONNECT', 0xc00d0006, 'Unable to establish a connection to the server.')

    # (0xc00d0007) Unable to destroy the title.
    NS_E_CANNOTDESTROYTITLE = HResultCode.new('NS_E_CANNOTDESTROYTITLE', 0xc00d0007, 'Unable to destroy the title.')

    # (0xc00d0008) Unable to rename the title.
    NS_E_CANNOTRENAMETITLE = HResultCode.new('NS_E_CANNOTRENAMETITLE', 0xc00d0008, 'Unable to rename the title.')

    # (0xc00d0009) Unable to offline disk.
    NS_E_CANNOTOFFLINEDISK = HResultCode.new('NS_E_CANNOTOFFLINEDISK', 0xc00d0009, 'Unable to offline disk.')

    # (0xc00d000a) Unable to online disk.
    NS_E_CANNOTONLINEDISK = HResultCode.new('NS_E_CANNOTONLINEDISK', 0xc00d000a, 'Unable to online disk.')

    # (0xc00d000b) There is no file parser registered for this type of file.
    NS_E_NOREGISTEREDWALKER = HResultCode.new('NS_E_NOREGISTEREDWALKER', 0xc00d000b, 'There is no file parser registered for this type of file.')

    # (0xc00d000c) There is no data connection established.
    NS_E_NOFUNNEL = HResultCode.new('NS_E_NOFUNNEL', 0xc00d000c, 'There is no data connection established.')

    # (0xc00d000d) Failed to load the local play DLL.
    NS_E_NO_LOCALPLAY = HResultCode.new('NS_E_NO_LOCALPLAY', 0xc00d000d, 'Failed to load the local play DLL.')

    # (0xc00d000e) The network is busy.
    NS_E_NETWORK_BUSY = HResultCode.new('NS_E_NETWORK_BUSY', 0xc00d000e, 'The network is busy.')

    # (0xc00d000f) The server session limit was exceeded.
    NS_E_TOO_MANY_SESS = HResultCode.new('NS_E_TOO_MANY_SESS', 0xc00d000f, 'The server session limit was exceeded.')

    # (0xc00d0010) The network connection already exists.
    NS_E_ALREADY_CONNECTED = HResultCode.new('NS_E_ALREADY_CONNECTED', 0xc00d0010, 'The network connection already exists.')

    # (0xc00d0011) Index %1 is invalid.
    NS_E_INVALID_INDEX = HResultCode.new('NS_E_INVALID_INDEX', 0xc00d0011, 'Index %1 is invalid.')

    # (0xc00d0012) There is no protocol or protocol version supported by both the client and the server.
    NS_E_PROTOCOL_MISMATCH = HResultCode.new('NS_E_PROTOCOL_MISMATCH', 0xc00d0012, 'There is no protocol or protocol version supported by both the client and the server.')

    # (0xc00d0013) The server, a computer set up to offer multimedia content to other computers, could not handle your request for multimedia content in a timely manner. Please try again later.
    NS_E_TIMEOUT = HResultCode.new('NS_E_TIMEOUT', 0xc00d0013, 'The server, a computer set up to offer multimedia content to other computers, could not handle your request for multimedia content in a timely manner. Please try again later.')

    # (0xc00d0014) Error writing to the network.
    NS_E_NET_WRITE = HResultCode.new('NS_E_NET_WRITE', 0xc00d0014, 'Error writing to the network.')

    # (0xc00d0015) Error reading from the network.
    NS_E_NET_READ = HResultCode.new('NS_E_NET_READ', 0xc00d0015, 'Error reading from the network.')

    # (0xc00d0016) Error writing to a disk.
    NS_E_DISK_WRITE = HResultCode.new('NS_E_DISK_WRITE', 0xc00d0016, 'Error writing to a disk.')

    # (0xc00d0017) Error reading from a disk.
    NS_E_DISK_READ = HResultCode.new('NS_E_DISK_READ', 0xc00d0017, 'Error reading from a disk.')

    # (0xc00d0018) Error writing to a file.
    NS_E_FILE_WRITE = HResultCode.new('NS_E_FILE_WRITE', 0xc00d0018, 'Error writing to a file.')

    # (0xc00d0019) Error reading from a file.
    NS_E_FILE_READ = HResultCode.new('NS_E_FILE_READ', 0xc00d0019, 'Error reading from a file.')

    # (0xc00d001a) The system cannot find the file specified.
    NS_E_FILE_NOT_FOUND = HResultCode.new('NS_E_FILE_NOT_FOUND', 0xc00d001a, 'The system cannot find the file specified.')

    # (0xc00d001b) The file already exists.
    NS_E_FILE_EXISTS = HResultCode.new('NS_E_FILE_EXISTS', 0xc00d001b, 'The file already exists.')

    # (0xc00d001c) The file name, directory name, or volume label syntax is incorrect.
    NS_E_INVALID_NAME = HResultCode.new('NS_E_INVALID_NAME', 0xc00d001c, 'The file name, directory name, or volume label syntax is incorrect.')

    # (0xc00d001d) Failed to open a file.
    NS_E_FILE_OPEN_FAILED = HResultCode.new('NS_E_FILE_OPEN_FAILED', 0xc00d001d, 'Failed to open a file.')

    # (0xc00d001e) Unable to allocate a file.
    NS_E_FILE_ALLOCATION_FAILED = HResultCode.new('NS_E_FILE_ALLOCATION_FAILED', 0xc00d001e, 'Unable to allocate a file.')

    # (0xc00d001f) Unable to initialize a file.
    NS_E_FILE_INIT_FAILED = HResultCode.new('NS_E_FILE_INIT_FAILED', 0xc00d001f, 'Unable to initialize a file.')

    # (0xc00d0020) Unable to play a file.
    NS_E_FILE_PLAY_FAILED = HResultCode.new('NS_E_FILE_PLAY_FAILED', 0xc00d0020, 'Unable to play a file.')

    # (0xc00d0021) Could not set the disk UID.
    NS_E_SET_DISK_UID_FAILED = HResultCode.new('NS_E_SET_DISK_UID_FAILED', 0xc00d0021, 'Could not set the disk UID.')

    # (0xc00d0022) An error was induced for testing purposes.
    NS_E_INDUCED = HResultCode.new('NS_E_INDUCED', 0xc00d0022, 'An error was induced for testing purposes.')

    # (0xc00d0023) Two Content Servers failed to communicate.
    NS_E_CCLINK_DOWN = HResultCode.new('NS_E_CCLINK_DOWN', 0xc00d0023, 'Two Content Servers failed to communicate.')

    # (0xc00d0024) An unknown error occurred.
    NS_E_INTERNAL = HResultCode.new('NS_E_INTERNAL', 0xc00d0024, 'An unknown error occurred.')

    # (0xc00d0025) The requested resource is in use.
    NS_E_BUSY = HResultCode.new('NS_E_BUSY', 0xc00d0025, 'The requested resource is in use.')

    # (0xc00d0026) The specified protocol is not recognized. Be sure that the file name and syntax, such as slashes, are correct for the protocol.
    NS_E_UNRECOGNIZED_STREAM_TYPE = HResultCode.new('NS_E_UNRECOGNIZED_STREAM_TYPE', 0xc00d0026, 'The specified protocol is not recognized. Be sure that the file name and syntax, such as slashes, are correct for the protocol.')

    # (0xc00d0027) The network service provider failed.
    NS_E_NETWORK_SERVICE_FAILURE = HResultCode.new('NS_E_NETWORK_SERVICE_FAILURE', 0xc00d0027, 'The network service provider failed.')

    # (0xc00d0028) An attempt to acquire a network resource failed.
    NS_E_NETWORK_RESOURCE_FAILURE = HResultCode.new('NS_E_NETWORK_RESOURCE_FAILURE', 0xc00d0028, 'An attempt to acquire a network resource failed.')

    # (0xc00d0029) The network connection has failed.
    NS_E_CONNECTION_FAILURE = HResultCode.new('NS_E_CONNECTION_FAILURE', 0xc00d0029, 'The network connection has failed.')

    # (0xc00d002a) The session is being terminated locally.
    NS_E_SHUTDOWN = HResultCode.new('NS_E_SHUTDOWN', 0xc00d002a, 'The session is being terminated locally.')

    # (0xc00d002b) The request is invalid in the current state.
    NS_E_INVALID_REQUEST = HResultCode.new('NS_E_INVALID_REQUEST', 0xc00d002b, 'The request is invalid in the current state.')

    # (0xc00d002c) There is insufficient bandwidth available to fulfill the request.
    NS_E_INSUFFICIENT_BANDWIDTH = HResultCode.new('NS_E_INSUFFICIENT_BANDWIDTH', 0xc00d002c, 'There is insufficient bandwidth available to fulfill the request.')

    # (0xc00d002d) The disk is not rebuilding.
    NS_E_NOT_REBUILDING = HResultCode.new('NS_E_NOT_REBUILDING', 0xc00d002d, 'The disk is not rebuilding.')

    # (0xc00d002e) An operation requested for a particular time could not be carried out on schedule.
    NS_E_LATE_OPERATION = HResultCode.new('NS_E_LATE_OPERATION', 0xc00d002e, 'An operation requested for a particular time could not be carried out on schedule.')

    # (0xc00d002f) Invalid or corrupt data was encountered.
    NS_E_INVALID_DATA = HResultCode.new('NS_E_INVALID_DATA', 0xc00d002f, 'Invalid or corrupt data was encountered.')

    # (0xc00d0030) The bandwidth required to stream a file is higher than the maximum file bandwidth allowed on the server.
    NS_E_FILE_BANDWIDTH_LIMIT = HResultCode.new('NS_E_FILE_BANDWIDTH_LIMIT', 0xc00d0030, 'The bandwidth required to stream a file is higher than the maximum file bandwidth allowed on the server.')

    # (0xc00d0031) The client cannot have any more files open simultaneously.
    NS_E_OPEN_FILE_LIMIT = HResultCode.new('NS_E_OPEN_FILE_LIMIT', 0xc00d0031, 'The client cannot have any more files open simultaneously.')

    # (0xc00d0032) The server received invalid data from the client on the control connection.
    NS_E_BAD_CONTROL_DATA = HResultCode.new('NS_E_BAD_CONTROL_DATA', 0xc00d0032, 'The server received invalid data from the client on the control connection.')

    # (0xc00d0033) There is no stream available.
    NS_E_NO_STREAM = HResultCode.new('NS_E_NO_STREAM', 0xc00d0033, 'There is no stream available.')

    # (0xc00d0034) There is no more data in the stream.
    NS_E_STREAM_END = HResultCode.new('NS_E_STREAM_END', 0xc00d0034, 'There is no more data in the stream.')

    # (0xc00d0035) The specified server could not be found.
    NS_E_SERVER_NOT_FOUND = HResultCode.new('NS_E_SERVER_NOT_FOUND', 0xc00d0035, 'The specified server could not be found.')

    # (0xc00d0036) The specified name is already in use.
    NS_E_DUPLICATE_NAME = HResultCode.new('NS_E_DUPLICATE_NAME', 0xc00d0036, 'The specified name is already in use.')

    # (0xc00d0037) The specified address is already in use.
    NS_E_DUPLICATE_ADDRESS = HResultCode.new('NS_E_DUPLICATE_ADDRESS', 0xc00d0037, 'The specified address is already in use.')

    # (0xc00d0038) The specified address is not a valid multicast address.
    NS_E_BAD_MULTICAST_ADDRESS = HResultCode.new('NS_E_BAD_MULTICAST_ADDRESS', 0xc00d0038, 'The specified address is not a valid multicast address.')

    # (0xc00d0039) The specified adapter address is invalid.
    NS_E_BAD_ADAPTER_ADDRESS = HResultCode.new('NS_E_BAD_ADAPTER_ADDRESS', 0xc00d0039, 'The specified adapter address is invalid.')

    # (0xc00d003a) The specified delivery mode is invalid.
    NS_E_BAD_DELIVERY_MODE = HResultCode.new('NS_E_BAD_DELIVERY_MODE', 0xc00d003a, 'The specified delivery mode is invalid.')

    # (0xc00d003b) The specified station does not exist.
    NS_E_INVALID_CHANNEL = HResultCode.new('NS_E_INVALID_CHANNEL', 0xc00d003b, 'The specified station does not exist.')

    # (0xc00d003c) The specified stream does not exist.
    NS_E_INVALID_STREAM = HResultCode.new('NS_E_INVALID_STREAM', 0xc00d003c, 'The specified stream does not exist.')

    # (0xc00d003d) The specified archive could not be opened.
    NS_E_INVALID_ARCHIVE = HResultCode.new('NS_E_INVALID_ARCHIVE', 0xc00d003d, 'The specified archive could not be opened.')

    # (0xc00d003e) The system cannot find any titles on the server.
    NS_E_NOTITLES = HResultCode.new('NS_E_NOTITLES', 0xc00d003e, 'The system cannot find any titles on the server.')

    # (0xc00d003f) The system cannot find the client specified.
    NS_E_INVALID_CLIENT = HResultCode.new('NS_E_INVALID_CLIENT', 0xc00d003f, 'The system cannot find the client specified.')

    # (0xc00d0040) The Blackhole Address is not initialized.
    NS_E_INVALID_BLACKHOLE_ADDRESS = HResultCode.new('NS_E_INVALID_BLACKHOLE_ADDRESS', 0xc00d0040, 'The Blackhole Address is not initialized.')

    # (0xc00d0041) The station does not support the stream format.
    NS_E_INCOMPATIBLE_FORMAT = HResultCode.new('NS_E_INCOMPATIBLE_FORMAT', 0xc00d0041, 'The station does not support the stream format.')

    # (0xc00d0042) The specified key is not valid.
    NS_E_INVALID_KEY = HResultCode.new('NS_E_INVALID_KEY', 0xc00d0042, 'The specified key is not valid.')

    # (0xc00d0043) The specified port is not valid.
    NS_E_INVALID_PORT = HResultCode.new('NS_E_INVALID_PORT', 0xc00d0043, 'The specified port is not valid.')

    # (0xc00d0044) The specified TTL is not valid.
    NS_E_INVALID_TTL = HResultCode.new('NS_E_INVALID_TTL', 0xc00d0044, 'The specified TTL is not valid.')

    # (0xc00d0045) The request to fast forward or rewind could not be fulfilled.
    NS_E_STRIDE_REFUSED = HResultCode.new('NS_E_STRIDE_REFUSED', 0xc00d0045, 'The request to fast forward or rewind could not be fulfilled.')

    # (0xc00d0046) Unable to load the appropriate file parser.
    NS_E_MMSAUTOSERVER_CANTFINDWALKER = HResultCode.new('NS_E_MMSAUTOSERVER_CANTFINDWALKER', 0xc00d0046, 'Unable to load the appropriate file parser.')

    # (0xc00d0047) Cannot exceed the maximum bandwidth limit.
    NS_E_MAX_BITRATE = HResultCode.new('NS_E_MAX_BITRATE', 0xc00d0047, 'Cannot exceed the maximum bandwidth limit.')

    # (0xc00d0048) Invalid value for LogFilePeriod.
    NS_E_LOGFILEPERIOD = HResultCode.new('NS_E_LOGFILEPERIOD', 0xc00d0048, 'Invalid value for LogFilePeriod.')

    # (0xc00d0049) Cannot exceed the maximum client limit.
    NS_E_MAX_CLIENTS = HResultCode.new('NS_E_MAX_CLIENTS', 0xc00d0049, 'Cannot exceed the maximum client limit.')

    # (0xc00d004a) The maximum log file size has been reached.
    NS_E_LOG_FILE_SIZE = HResultCode.new('NS_E_LOG_FILE_SIZE', 0xc00d004a, 'The maximum log file size has been reached.')

    # (0xc00d004b) Cannot exceed the maximum file rate.
    NS_E_MAX_FILERATE = HResultCode.new('NS_E_MAX_FILERATE', 0xc00d004b, 'Cannot exceed the maximum file rate.')

    # (0xc00d004c) Unknown file type.
    NS_E_WALKER_UNKNOWN = HResultCode.new('NS_E_WALKER_UNKNOWN', 0xc00d004c, 'Unknown file type.')

    # (0xc00d004d) The specified file, %1, cannot be loaded onto the specified server, %2.
    NS_E_WALKER_SERVER = HResultCode.new('NS_E_WALKER_SERVER', 0xc00d004d, 'The specified file, %1, cannot be loaded onto the specified server, %2.')

    # (0xc00d004e) There was a usage error with file parser.
    NS_E_WALKER_USAGE = HResultCode.new('NS_E_WALKER_USAGE', 0xc00d004e, 'There was a usage error with file parser.')

    # (0xc00d0050) The Title Server %1 has failed.
    NS_E_TIGER_FAIL = HResultCode.new('NS_E_TIGER_FAIL', 0xc00d0050, 'The Title Server %1 has failed.')

    # (0xc00d0053) Content Server %1 (%2) has failed.
    NS_E_CUB_FAIL = HResultCode.new('NS_E_CUB_FAIL', 0xc00d0053, 'Content Server %1 (%2) has failed.')

    # (0xc00d0055) Disk %1 ( %2 ) on Content Server %3, has failed.
    NS_E_DISK_FAIL = HResultCode.new('NS_E_DISK_FAIL', 0xc00d0055, 'Disk %1 ( %2 ) on Content Server %3, has failed.')

    # (0xc00d0060) The NetShow data stream limit of %1 streams was reached.
    NS_E_MAX_FUNNELS_ALERT = HResultCode.new('NS_E_MAX_FUNNELS_ALERT', 0xc00d0060, 'The NetShow data stream limit of %1 streams was reached.')

    # (0xc00d0061) The NetShow Video Server was unable to allocate a %1 block file named %2.
    NS_E_ALLOCATE_FILE_FAIL = HResultCode.new('NS_E_ALLOCATE_FILE_FAIL', 0xc00d0061, 'The NetShow Video Server was unable to allocate a %1 block file named %2.')

    # (0xc00d0062) A Content Server was unable to page a block.
    NS_E_PAGING_ERROR = HResultCode.new('NS_E_PAGING_ERROR', 0xc00d0062, 'A Content Server was unable to page a block.')

    # (0xc00d0063) Disk %1 has unrecognized control block version %2.
    NS_E_BAD_BLOCK0_VERSION = HResultCode.new('NS_E_BAD_BLOCK0_VERSION', 0xc00d0063, 'Disk %1 has unrecognized control block version %2.')

    # (0xc00d0064) Disk %1 has incorrect uid %2.
    NS_E_BAD_DISK_UID = HResultCode.new('NS_E_BAD_DISK_UID', 0xc00d0064, 'Disk %1 has incorrect uid %2.')

    # (0xc00d0065) Disk %1 has unsupported file system major version %2.
    NS_E_BAD_FSMAJOR_VERSION = HResultCode.new('NS_E_BAD_FSMAJOR_VERSION', 0xc00d0065, 'Disk %1 has unsupported file system major version %2.')

    # (0xc00d0066) Disk %1 has bad stamp number in control block.
    NS_E_BAD_STAMPNUMBER = HResultCode.new('NS_E_BAD_STAMPNUMBER', 0xc00d0066, 'Disk %1 has bad stamp number in control block.')

    # (0xc00d0067) Disk %1 is partially reconstructed.
    NS_E_PARTIALLY_REBUILT_DISK = HResultCode.new('NS_E_PARTIALLY_REBUILT_DISK', 0xc00d0067, 'Disk %1 is partially reconstructed.')

    # (0xc00d0068) EnactPlan gives up.
    NS_E_ENACTPLAN_GIVEUP = HResultCode.new('NS_E_ENACTPLAN_GIVEUP', 0xc00d0068, 'EnactPlan gives up.')

    # (0xc00d006a) The key was not found in the registry.
    MCMADM_E_REGKEY_NOT_FOUND = HResultCode.new('MCMADM_E_REGKEY_NOT_FOUND', 0xc00d006a, 'The key was not found in the registry.')

    # (0xc00d006b) The publishing point cannot be started because the server does not have the appropriate stream formats. Use the Multicast Announcement Wizard to create a new announcement for this publishing point.
    NS_E_NO_FORMATS = HResultCode.new('NS_E_NO_FORMATS', 0xc00d006b, 'The publishing point cannot be started because the server does not have the appropriate stream formats. Use the Multicast Announcement Wizard to create a new announcement for this publishing point.')

    # (0xc00d006c) No reference URLs were found in an ASX file.
    NS_E_NO_REFERENCES = HResultCode.new('NS_E_NO_REFERENCES', 0xc00d006c, 'No reference URLs were found in an ASX file.')

    # (0xc00d006d) Error opening wave device, the device might be in use.
    NS_E_WAVE_OPEN = HResultCode.new('NS_E_WAVE_OPEN', 0xc00d006d, 'Error opening wave device, the device might be in use.')

    # (0xc00d006f) Unable to establish a connection to the NetShow event monitor service.
    NS_E_CANNOTCONNECTEVENTS = HResultCode.new('NS_E_CANNOTCONNECTEVENTS', 0xc00d006f, 'Unable to establish a connection to the NetShow event monitor service.')

    # (0xc00d0071) No device driver is present on the system.
    NS_E_NO_DEVICE = HResultCode.new('NS_E_NO_DEVICE', 0xc00d0071, 'No device driver is present on the system.')

    # (0xc00d0072) No specified device driver is present.
    NS_E_NO_SPECIFIED_DEVICE = HResultCode.new('NS_E_NO_SPECIFIED_DEVICE', 0xc00d0072, 'No specified device driver is present.')

    # (0xc00d00c8) Netshow Events Monitor is not operational and has been disconnected.
    NS_E_MONITOR_GIVEUP = HResultCode.new('NS_E_MONITOR_GIVEUP', 0xc00d00c8, 'Netshow Events Monitor is not operational and has been disconnected.')

    # (0xc00d00c9) Disk %1 is remirrored.
    NS_E_REMIRRORED_DISK = HResultCode.new('NS_E_REMIRRORED_DISK', 0xc00d00c9, 'Disk %1 is remirrored.')

    # (0xc00d00ca) Insufficient data found.
    NS_E_INSUFFICIENT_DATA = HResultCode.new('NS_E_INSUFFICIENT_DATA', 0xc00d00ca, 'Insufficient data found.')

    # (0xc00d00cb) 1 failed in file %2 line %3.
    NS_E_ASSERT = HResultCode.new('NS_E_ASSERT', 0xc00d00cb, '1 failed in file %2 line %3.')

    # (0xc00d00cc) The specified adapter name is invalid.
    NS_E_BAD_ADAPTER_NAME = HResultCode.new('NS_E_BAD_ADAPTER_NAME', 0xc00d00cc, 'The specified adapter name is invalid.')

    # (0xc00d00cd) The application is not licensed for this feature.
    NS_E_NOT_LICENSED = HResultCode.new('NS_E_NOT_LICENSED', 0xc00d00cd, 'The application is not licensed for this feature.')

    # (0xc00d00ce) Unable to contact the server.
    NS_E_NO_SERVER_CONTACT = HResultCode.new('NS_E_NO_SERVER_CONTACT', 0xc00d00ce, 'Unable to contact the server.')

    # (0xc00d00cf) Maximum number of titles exceeded.
    NS_E_TOO_MANY_TITLES = HResultCode.new('NS_E_TOO_MANY_TITLES', 0xc00d00cf, 'Maximum number of titles exceeded.')

    # (0xc00d00d0) Maximum size of a title exceeded.
    NS_E_TITLE_SIZE_EXCEEDED = HResultCode.new('NS_E_TITLE_SIZE_EXCEEDED', 0xc00d00d0, 'Maximum size of a title exceeded.')

    # (0xc00d00d1) UDP protocol not enabled. Not trying %1!ls!.
    NS_E_UDP_DISABLED = HResultCode.new('NS_E_UDP_DISABLED', 0xc00d00d1, 'UDP protocol not enabled. Not trying %1!ls!.')

    # (0xc00d00d2) TCP protocol not enabled. Not trying %1!ls!.
    NS_E_TCP_DISABLED = HResultCode.new('NS_E_TCP_DISABLED', 0xc00d00d2, 'TCP protocol not enabled. Not trying %1!ls!.')

    # (0xc00d00d3) HTTP protocol not enabled. Not trying %1!ls!.
    NS_E_HTTP_DISABLED = HResultCode.new('NS_E_HTTP_DISABLED', 0xc00d00d3, 'HTTP protocol not enabled. Not trying %1!ls!.')

    # (0xc00d00d4) The product license has expired.
    NS_E_LICENSE_EXPIRED = HResultCode.new('NS_E_LICENSE_EXPIRED', 0xc00d00d4, 'The product license has expired.')

    # (0xc00d00d5) Source file exceeds the per title maximum bitrate. See NetShow Theater documentation for more information.
    NS_E_TITLE_BITRATE = HResultCode.new('NS_E_TITLE_BITRATE', 0xc00d00d5, 'Source file exceeds the per title maximum bitrate. See NetShow Theater documentation for more information.')

    # (0xc00d00d6) The program name cannot be empty.
    NS_E_EMPTY_PROGRAM_NAME = HResultCode.new('NS_E_EMPTY_PROGRAM_NAME', 0xc00d00d6, 'The program name cannot be empty.')

    # (0xc00d00d7) Station %1 does not exist.
    NS_E_MISSING_CHANNEL = HResultCode.new('NS_E_MISSING_CHANNEL', 0xc00d00d7, 'Station %1 does not exist.')

    # (0xc00d00d8) You need to define at least one station before this operation can complete.
    NS_E_NO_CHANNELS = HResultCode.new('NS_E_NO_CHANNELS', 0xc00d00d8, 'You need to define at least one station before this operation can complete.')

    # (0xc00d00d9) The index specified is invalid.
    NS_E_INVALID_INDEX2 = HResultCode.new('NS_E_INVALID_INDEX2', 0xc00d00d9, 'The index specified is invalid.')

    # (0xc00d0190) Content Server %1 (%2) has failed its link to Content Server %3.
    NS_E_CUB_FAIL_LINK = HResultCode.new('NS_E_CUB_FAIL_LINK', 0xc00d0190, 'Content Server %1 (%2) has failed its link to Content Server %3.')

    # (0xc00d0192) Content Server %1 (%2) has incorrect uid %3.
    NS_E_BAD_CUB_UID = HResultCode.new('NS_E_BAD_CUB_UID', 0xc00d0192, 'Content Server %1 (%2) has incorrect uid %3.')

    # (0xc00d0195) Server unreliable because multiple components failed.
    NS_E_GLITCH_MODE = HResultCode.new('NS_E_GLITCH_MODE', 0xc00d0195, 'Server unreliable because multiple components failed.')

    # (0xc00d019b) Content Server %1 (%2) is unable to communicate with the Media System Network Protocol.
    NS_E_NO_MEDIA_PROTOCOL = HResultCode.new('NS_E_NO_MEDIA_PROTOCOL', 0xc00d019b, 'Content Server %1 (%2) is unable to communicate with the Media System Network Protocol.')

    # (0xc00d07f1) Nothing to do.
    NS_E_NOTHING_TO_DO = HResultCode.new('NS_E_NOTHING_TO_DO', 0xc00d07f1, 'Nothing to do.')

    # (0xc00d07f2) Not receiving data from the server.
    NS_E_NO_MULTICAST = HResultCode.new('NS_E_NO_MULTICAST', 0xc00d07f2, 'Not receiving data from the server.')

    # (0xc00d0bb8) The input media format is invalid.
    NS_E_INVALID_INPUT_FORMAT = HResultCode.new('NS_E_INVALID_INPUT_FORMAT', 0xc00d0bb8, 'The input media format is invalid.')

    # (0xc00d0bb9) The MSAudio codec is not installed on this system.
    NS_E_MSAUDIO_NOT_INSTALLED = HResultCode.new('NS_E_MSAUDIO_NOT_INSTALLED', 0xc00d0bb9, 'The MSAudio codec is not installed on this system.')

    # (0xc00d0bba) An unexpected error occurred with the MSAudio codec.
    NS_E_UNEXPECTED_MSAUDIO_ERROR = HResultCode.new('NS_E_UNEXPECTED_MSAUDIO_ERROR', 0xc00d0bba, 'An unexpected error occurred with the MSAudio codec.')

    # (0xc00d0bbb) The output media format is invalid.
    NS_E_INVALID_OUTPUT_FORMAT = HResultCode.new('NS_E_INVALID_OUTPUT_FORMAT', 0xc00d0bbb, 'The output media format is invalid.')

    # (0xc00d0bbc) The object must be fully configured before audio samples can be processed.
    NS_E_NOT_CONFIGURED = HResultCode.new('NS_E_NOT_CONFIGURED', 0xc00d0bbc, 'The object must be fully configured before audio samples can be processed.')

    # (0xc00d0bbd) You need a license to perform the requested operation on this media file.
    NS_E_PROTECTED_CONTENT = HResultCode.new('NS_E_PROTECTED_CONTENT', 0xc00d0bbd, 'You need a license to perform the requested operation on this media file.')

    # (0xc00d0bbe) You need a license to perform the requested operation on this media file.
    NS_E_LICENSE_REQUIRED = HResultCode.new('NS_E_LICENSE_REQUIRED', 0xc00d0bbe, 'You need a license to perform the requested operation on this media file.')

    # (0xc00d0bbf) This media file is corrupted or invalid. Contact the content provider for a new file.
    NS_E_TAMPERED_CONTENT = HResultCode.new('NS_E_TAMPERED_CONTENT', 0xc00d0bbf, 'This media file is corrupted or invalid. Contact the content provider for a new file.')

    # (0xc00d0bc0) The license for this media file has expired. Get a new license or contact the content provider for further assistance.
    NS_E_LICENSE_OUTOFDATE = HResultCode.new('NS_E_LICENSE_OUTOFDATE', 0xc00d0bc0, 'The license for this media file has expired. Get a new license or contact the content provider for further assistance.')

    # (0xc00d0bc1) You are not allowed to open this file. Contact the content provider for further assistance.
    NS_E_LICENSE_INCORRECT_RIGHTS = HResultCode.new('NS_E_LICENSE_INCORRECT_RIGHTS', 0xc00d0bc1, 'You are not allowed to open this file. Contact the content provider for further assistance.')

    # (0xc00d0bc2) The requested audio codec is not installed on this system.
    NS_E_AUDIO_CODEC_NOT_INSTALLED = HResultCode.new('NS_E_AUDIO_CODEC_NOT_INSTALLED', 0xc00d0bc2, 'The requested audio codec is not installed on this system.')

    # (0xc00d0bc3) An unexpected error occurred with the audio codec.
    NS_E_AUDIO_CODEC_ERROR = HResultCode.new('NS_E_AUDIO_CODEC_ERROR', 0xc00d0bc3, 'An unexpected error occurred with the audio codec.')

    # (0xc00d0bc4) The requested video codec is not installed on this system.
    NS_E_VIDEO_CODEC_NOT_INSTALLED = HResultCode.new('NS_E_VIDEO_CODEC_NOT_INSTALLED', 0xc00d0bc4, 'The requested video codec is not installed on this system.')

    # (0xc00d0bc5) An unexpected error occurred with the video codec.
    NS_E_VIDEO_CODEC_ERROR = HResultCode.new('NS_E_VIDEO_CODEC_ERROR', 0xc00d0bc5, 'An unexpected error occurred with the video codec.')

    # (0xc00d0bc6) The Profile is invalid.
    NS_E_INVALIDPROFILE = HResultCode.new('NS_E_INVALIDPROFILE', 0xc00d0bc6, 'The Profile is invalid.')

    # (0xc00d0bc7) A new version of the SDK is needed to play the requested content.
    NS_E_INCOMPATIBLE_VERSION = HResultCode.new('NS_E_INCOMPATIBLE_VERSION', 0xc00d0bc7, 'A new version of the SDK is needed to play the requested content.')

    # (0xc00d0bca) The requested URL is not available in offline mode.
    NS_E_OFFLINE_MODE = HResultCode.new('NS_E_OFFLINE_MODE', 0xc00d0bca, 'The requested URL is not available in offline mode.')

    # (0xc00d0bcb) The requested URL cannot be accessed because there is no network connection.
    NS_E_NOT_CONNECTED = HResultCode.new('NS_E_NOT_CONNECTED', 0xc00d0bcb, 'The requested URL cannot be accessed because there is no network connection.')

    # (0xc00d0bcc) The encoding process was unable to keep up with the amount of supplied data.
    NS_E_TOO_MUCH_DATA = HResultCode.new('NS_E_TOO_MUCH_DATA', 0xc00d0bcc, 'The encoding process was unable to keep up with the amount of supplied data.')

    # (0xc00d0bcd) The given property is not supported.
    NS_E_UNSUPPORTED_PROPERTY = HResultCode.new('NS_E_UNSUPPORTED_PROPERTY', 0xc00d0bcd, 'The given property is not supported.')

    # (0xc00d0bce) Windows Media Player cannot copy the files to the CD because they are 8-bit. Convert the files to 16-bit, 44-kHz stereo files by using Sound Recorder or another audio-processing program, and then try again.
    NS_E_8BIT_WAVE_UNSUPPORTED = HResultCode.new('NS_E_8BIT_WAVE_UNSUPPORTED', 0xc00d0bce, 'Windows Media Player cannot copy the files to the CD because they are 8-bit. Convert the files to 16-bit, 44-kHz stereo files by using Sound Recorder or another audio-processing program, and then try again.')

    # (0xc00d0bcf) There are no more samples in the current range.
    NS_E_NO_MORE_SAMPLES = HResultCode.new('NS_E_NO_MORE_SAMPLES', 0xc00d0bcf, 'There are no more samples in the current range.')

    # (0xc00d0bd0) The given sampling rate is invalid.
    NS_E_INVALID_SAMPLING_RATE = HResultCode.new('NS_E_INVALID_SAMPLING_RATE', 0xc00d0bd0, 'The given sampling rate is invalid.')

    # (0xc00d0bd1) The given maximum packet size is too small to accommodate this profile.)
    NS_E_MAX_PACKET_SIZE_TOO_SMALL = HResultCode.new('NS_E_MAX_PACKET_SIZE_TOO_SMALL', 0xc00d0bd1, 'The given maximum packet size is too small to accommodate this profile.)')

    # (0xc00d0bd2) The packet arrived too late to be of use.
    NS_E_LATE_PACKET = HResultCode.new('NS_E_LATE_PACKET', 0xc00d0bd2, 'The packet arrived too late to be of use.')

    # (0xc00d0bd3) The packet is a duplicate of one received before.
    NS_E_DUPLICATE_PACKET = HResultCode.new('NS_E_DUPLICATE_PACKET', 0xc00d0bd3, 'The packet is a duplicate of one received before.')

    # (0xc00d0bd4) Supplied buffer is too small.
    NS_E_SDK_BUFFERTOOSMALL = HResultCode.new('NS_E_SDK_BUFFERTOOSMALL', 0xc00d0bd4, 'Supplied buffer is too small.')

    # (0xc00d0bd5) The wrong number of preprocessing passes was used for the stream's output type.
    NS_E_INVALID_NUM_PASSES = HResultCode.new('NS_E_INVALID_NUM_PASSES', 0xc00d0bd5, 'The wrong number of preprocessing passes was used for the stream\'s output type.')

    # (0xc00d0bd6) An attempt was made to add, modify, or delete a read only attribute.
    NS_E_ATTRIBUTE_READ_ONLY = HResultCode.new('NS_E_ATTRIBUTE_READ_ONLY', 0xc00d0bd6, 'An attempt was made to add, modify, or delete a read only attribute.')

    # (0xc00d0bd7) An attempt was made to add attribute that is not allowed for the given media type.
    NS_E_ATTRIBUTE_NOT_ALLOWED = HResultCode.new('NS_E_ATTRIBUTE_NOT_ALLOWED', 0xc00d0bd7, 'An attempt was made to add attribute that is not allowed for the given media type.')

    # (0xc00d0bd8) The EDL provided is invalid.
    NS_E_INVALID_EDL = HResultCode.new('NS_E_INVALID_EDL', 0xc00d0bd8, 'The EDL provided is invalid.')

    # (0xc00d0bd9) The Data Unit Extension data was too large to be used.
    NS_E_DATA_UNIT_EXTENSION_TOO_LARGE = HResultCode.new('NS_E_DATA_UNIT_EXTENSION_TOO_LARGE', 0xc00d0bd9, 'The Data Unit Extension data was too large to be used.')

    # (0xc00d0bda) An unexpected error occurred with a DMO codec.
    NS_E_CODEC_DMO_ERROR = HResultCode.new('NS_E_CODEC_DMO_ERROR', 0xc00d0bda, 'An unexpected error occurred with a DMO codec.')

    # (0xc00d0bdc) This feature has been disabled by group policy.
    NS_E_FEATURE_DISABLED_BY_GROUP_POLICY = HResultCode.new('NS_E_FEATURE_DISABLED_BY_GROUP_POLICY', 0xc00d0bdc, 'This feature has been disabled by group policy.')

    # (0xc00d0bdd) This feature is disabled in this SKU.
    NS_E_FEATURE_DISABLED_IN_SKU = HResultCode.new('NS_E_FEATURE_DISABLED_IN_SKU', 0xc00d0bdd, 'This feature is disabled in this SKU.')

    # (0xc00d0fa0) There is no CD in the CD drive. Insert a CD, and then try again.
    NS_E_NO_CD = HResultCode.new('NS_E_NO_CD', 0xc00d0fa0, 'There is no CD in the CD drive. Insert a CD, and then try again.')

    # (0xc00d0fa1) Windows Media Player could not use digital playback to play the CD. To switch to analog playback, on the Tools menu, click Options, and then click the Devices tab. Double-click the CD drive, and then in the Playback area, click Analog. For additional assistance, click Web Help.
    NS_E_CANT_READ_DIGITAL = HResultCode.new('NS_E_CANT_READ_DIGITAL', 0xc00d0fa1, 'Windows Media Player could not use digital playback to play the CD. To switch to analog playback, on the Tools menu, click Options, and then click the Devices tab. Double-click the CD drive, and then in the Playback area, click Analog. For additional assistance, click Web Help.')

    # (0xc00d0fa2) Windows Media Player no longer detects a connected portable device. Reconnect your portable device, and then try synchronizing the file again.
    NS_E_DEVICE_DISCONNECTED = HResultCode.new('NS_E_DEVICE_DISCONNECTED', 0xc00d0fa2, 'Windows Media Player no longer detects a connected portable device. Reconnect your portable device, and then try synchronizing the file again.')

    # (0xc00d0fa3) Windows Media Player cannot play the file. The portable device does not support the specified file type.
    NS_E_DEVICE_NOT_SUPPORT_FORMAT = HResultCode.new('NS_E_DEVICE_NOT_SUPPORT_FORMAT', 0xc00d0fa3, 'Windows Media Player cannot play the file. The portable device does not support the specified file type.')

    # (0xc00d0fa4) Windows Media Player could not use digital playback to play the CD. The Player has automatically switched the CD drive to analog playback. To switch back to digital CD playback, use the Devices tab. For additional assistance, click Web Help.
    NS_E_SLOW_READ_DIGITAL = HResultCode.new('NS_E_SLOW_READ_DIGITAL', 0xc00d0fa4, 'Windows Media Player could not use digital playback to play the CD. The Player has automatically switched the CD drive to analog playback. To switch back to digital CD playback, use the Devices tab. For additional assistance, click Web Help.')

    # (0xc00d0fa5) An invalid line error occurred in the mixer.
    NS_E_MIXER_INVALID_LINE = HResultCode.new('NS_E_MIXER_INVALID_LINE', 0xc00d0fa5, 'An invalid line error occurred in the mixer.')

    # (0xc00d0fa6) An invalid control error occurred in the mixer.
    NS_E_MIXER_INVALID_CONTROL = HResultCode.new('NS_E_MIXER_INVALID_CONTROL', 0xc00d0fa6, 'An invalid control error occurred in the mixer.')

    # (0xc00d0fa7) An invalid value error occurred in the mixer.
    NS_E_MIXER_INVALID_VALUE = HResultCode.new('NS_E_MIXER_INVALID_VALUE', 0xc00d0fa7, 'An invalid value error occurred in the mixer.')

    # (0xc00d0fa8) An unrecognized MMRESULT occurred in the mixer.
    NS_E_MIXER_UNKNOWN_MMRESULT = HResultCode.new('NS_E_MIXER_UNKNOWN_MMRESULT', 0xc00d0fa8, 'An unrecognized MMRESULT occurred in the mixer.')

    # (0xc00d0fa9) User has stopped the operation.
    NS_E_USER_STOP = HResultCode.new('NS_E_USER_STOP', 0xc00d0fa9, 'User has stopped the operation.')

    # (0xc00d0faa) Windows Media Player cannot rip the track because a compatible MP3 encoder is not installed on your computer. Install a compatible MP3 encoder or choose a different format to rip to (such as Windows Media Audio).
    NS_E_MP3_FORMAT_NOT_FOUND = HResultCode.new('NS_E_MP3_FORMAT_NOT_FOUND', 0xc00d0faa, 'Windows Media Player cannot rip the track because a compatible MP3 encoder is not installed on your computer. Install a compatible MP3 encoder or choose a different format to rip to (such as Windows Media Audio).')

    # (0xc00d0fab) Windows Media Player cannot read the CD. The disc might be dirty or damaged. Turn on error correction, and then try again.
    NS_E_CD_READ_ERROR_NO_CORRECTION = HResultCode.new('NS_E_CD_READ_ERROR_NO_CORRECTION', 0xc00d0fab, 'Windows Media Player cannot read the CD. The disc might be dirty or damaged. Turn on error correction, and then try again.')

    # (0xc00d0fac) Windows Media Player cannot read the CD. The disc might be dirty or damaged or the CD drive might be malfunctioning.
    NS_E_CD_READ_ERROR = HResultCode.new('NS_E_CD_READ_ERROR', 0xc00d0fac, 'Windows Media Player cannot read the CD. The disc might be dirty or damaged or the CD drive might be malfunctioning.')

    # (0xc00d0fad) For best performance, do not play CD tracks while ripping them.
    NS_E_CD_SLOW_COPY = HResultCode.new('NS_E_CD_SLOW_COPY', 0xc00d0fad, 'For best performance, do not play CD tracks while ripping them.')

    # (0xc00d0fae) It is not possible to directly burn tracks from one CD to another CD. You must first rip the tracks from the CD to your computer, and then burn the files to a blank CD.
    NS_E_CD_COPYTO_CD = HResultCode.new('NS_E_CD_COPYTO_CD', 0xc00d0fae, 'It is not possible to directly burn tracks from one CD to another CD. You must first rip the tracks from the CD to your computer, and then burn the files to a blank CD.')

    # (0xc00d0faf) Could not open a sound mixer driver.
    NS_E_MIXER_NODRIVER = HResultCode.new('NS_E_MIXER_NODRIVER', 0xc00d0faf, 'Could not open a sound mixer driver.')

    # (0xc00d0fb0) Windows Media Player cannot rip tracks from the CD correctly because the CD drive settings in Device Manager do not match the CD drive settings in the Player.
    NS_E_REDBOOK_ENABLED_WHILE_COPYING = HResultCode.new('NS_E_REDBOOK_ENABLED_WHILE_COPYING', 0xc00d0fb0, 'Windows Media Player cannot rip tracks from the CD correctly because the CD drive settings in Device Manager do not match the CD drive settings in the Player.')

    # (0xc00d0fb1) Windows Media Player is busy reading the CD.
    NS_E_CD_REFRESH = HResultCode.new('NS_E_CD_REFRESH', 0xc00d0fb1, 'Windows Media Player is busy reading the CD.')

    # (0xc00d0fb2) Windows Media Player could not use digital playback to play the CD. The Player has automatically switched the CD drive to analog playback. To switch back to digital CD playback, use the Devices tab. For additional assistance, click Web Help.
    NS_E_CD_DRIVER_PROBLEM = HResultCode.new('NS_E_CD_DRIVER_PROBLEM', 0xc00d0fb2, 'Windows Media Player could not use digital playback to play the CD. The Player has automatically switched the CD drive to analog playback. To switch back to digital CD playback, use the Devices tab. For additional assistance, click Web Help.')

    # (0xc00d0fb3) Windows Media Player could not use digital playback to play the CD. The Player has automatically switched the CD drive to analog playback. To switch back to digital CD playback, use the Devices tab. For additional assistance, click Web Help.
    NS_E_WONT_DO_DIGITAL = HResultCode.new('NS_E_WONT_DO_DIGITAL', 0xc00d0fb3, 'Windows Media Player could not use digital playback to play the CD. The Player has automatically switched the CD drive to analog playback. To switch back to digital CD playback, use the Devices tab. For additional assistance, click Web Help.')

    # (0xc00d0fb4) A call was made to GetParseError on the XML parser but there was no error to retrieve.
    NS_E_WMPXML_NOERROR = HResultCode.new('NS_E_WMPXML_NOERROR', 0xc00d0fb4, 'A call was made to GetParseError on the XML parser but there was no error to retrieve.')

    # (0xc00d0fb5) The XML Parser ran out of data while parsing.
    NS_E_WMPXML_ENDOFDATA = HResultCode.new('NS_E_WMPXML_ENDOFDATA', 0xc00d0fb5, 'The XML Parser ran out of data while parsing.')

    # (0xc00d0fb6) A generic parse error occurred in the XML parser but no information is available.
    NS_E_WMPXML_PARSEERROR = HResultCode.new('NS_E_WMPXML_PARSEERROR', 0xc00d0fb6, 'A generic parse error occurred in the XML parser but no information is available.')

    # (0xc00d0fb7) A call get GetNamedAttribute or GetNamedAttributeIndex on the XML parser resulted in the index not being found.
    NS_E_WMPXML_ATTRIBUTENOTFOUND = HResultCode.new('NS_E_WMPXML_ATTRIBUTENOTFOUND', 0xc00d0fb7, 'A call get GetNamedAttribute or GetNamedAttributeIndex on the XML parser resulted in the index not being found.')

    # (0xc00d0fb8) A call was made go GetNamedPI on the XML parser, but the requested Processing Instruction was not found.
    NS_E_WMPXML_PINOTFOUND = HResultCode.new('NS_E_WMPXML_PINOTFOUND', 0xc00d0fb8, 'A call was made go GetNamedPI on the XML parser, but the requested Processing Instruction was not found.')

    # (0xc00d0fb9) Persist was called on the XML parser, but the parser has no data to persist.
    NS_E_WMPXML_EMPTYDOC = HResultCode.new('NS_E_WMPXML_EMPTYDOC', 0xc00d0fb9, 'Persist was called on the XML parser, but the parser has no data to persist.')

    # (0xc00d0fba) This file path is already in the library.
    NS_E_WMP_PATH_ALREADY_IN_LIBRARY = HResultCode.new('NS_E_WMP_PATH_ALREADY_IN_LIBRARY', 0xc00d0fba, 'This file path is already in the library.')

    # (0xc00d0fbe) Windows Media Player is already searching for files to add to your library. Wait for the current process to finish before attempting to search again.
    NS_E_WMP_FILESCANALREADYSTARTED = HResultCode.new('NS_E_WMP_FILESCANALREADYSTARTED', 0xc00d0fbe, 'Windows Media Player is already searching for files to add to your library. Wait for the current process to finish before attempting to search again.')

    # (0xc00d0fbf) Windows Media Player is unable to find the media you are looking for.
    NS_E_WMP_HME_INVALIDOBJECTID = HResultCode.new('NS_E_WMP_HME_INVALIDOBJECTID', 0xc00d0fbf, 'Windows Media Player is unable to find the media you are looking for.')

    # (0xc00d0fc0) A component of Windows Media Player is out-of-date. If you are running a pre-release version of Windows, try upgrading to a more recent version.
    NS_E_WMP_MF_CODE_EXPIRED = HResultCode.new('NS_E_WMP_MF_CODE_EXPIRED', 0xc00d0fc0, 'A component of Windows Media Player is out-of-date. If you are running a pre-release version of Windows, try upgrading to a more recent version.')

    # (0xc00d0fc1) This container does not support search on items.
    NS_E_WMP_HME_NOTSEARCHABLEFORITEMS = HResultCode.new('NS_E_WMP_HME_NOTSEARCHABLEFORITEMS', 0xc00d0fc1, 'This container does not support search on items.')

    # (0xc00d0fc7) Windows Media Player encountered a problem while adding one or more files to the library. For additional assistance, click Web Help.
    NS_E_WMP_ADDTOLIBRARY_FAILED = HResultCode.new('NS_E_WMP_ADDTOLIBRARY_FAILED', 0xc00d0fc7, 'Windows Media Player encountered a problem while adding one or more files to the library. For additional assistance, click Web Help.')

    # (0xc00d0fc8) A Windows API call failed but no error information was available.
    NS_E_WMP_WINDOWSAPIFAILURE = HResultCode.new('NS_E_WMP_WINDOWSAPIFAILURE', 0xc00d0fc8, 'A Windows API call failed but no error information was available.')

    # (0xc00d0fc9) This file does not have burn rights. If you obtained this file from an online store, go to the online store to get burn rights.
    NS_E_WMP_RECORDING_NOT_ALLOWED = HResultCode.new('NS_E_WMP_RECORDING_NOT_ALLOWED', 0xc00d0fc9, 'This file does not have burn rights. If you obtained this file from an online store, go to the online store to get burn rights.')

    # (0xc00d0fca) Windows Media Player no longer detects a connected portable device. Reconnect your portable device, and then try to sync the file again.
    NS_E_DEVICE_NOT_READY = HResultCode.new('NS_E_DEVICE_NOT_READY', 0xc00d0fca, 'Windows Media Player no longer detects a connected portable device. Reconnect your portable device, and then try to sync the file again.')

    # (0xc00d0fcb) Windows Media Player cannot play the file because it is corrupted.
    NS_E_DAMAGED_FILE = HResultCode.new('NS_E_DAMAGED_FILE', 0xc00d0fcb, 'Windows Media Player cannot play the file because it is corrupted.')

    # (0xc00d0fcc) Windows Media Player encountered an error while attempting to access information in the library. Try restarting the Player.
    NS_E_MPDB_GENERIC = HResultCode.new('NS_E_MPDB_GENERIC', 0xc00d0fcc, 'Windows Media Player encountered an error while attempting to access information in the library. Try restarting the Player.')

    # (0xc00d0fcd) The file cannot be added to the library because it is smaller than the "Skip files smaller than" setting. To add the file, change the setting on the Library tab. For additional assistance, click Web Help.
    NS_E_FILE_FAILED_CHECKS = HResultCode.new('NS_E_FILE_FAILED_CHECKS', 0xc00d0fcd, 'The file cannot be added to the library because it is smaller than the "Skip files smaller than" setting. To add the file, change the setting on the Library tab. For additional assistance, click Web Help.')

    # (0xc00d0fce) Windows Media Player cannot create the library. You must be logged on as an administrator or a member of the Administrators group to install the Player. For more information, contact your system administrator.
    NS_E_MEDIA_LIBRARY_FAILED = HResultCode.new('NS_E_MEDIA_LIBRARY_FAILED', 0xc00d0fce, 'Windows Media Player cannot create the library. You must be logged on as an administrator or a member of the Administrators group to install the Player. For more information, contact your system administrator.')

    # (0xc00d0fcf) The file is already in use. Close other programs that might be using the file, or stop playing the file, and then try again.
    NS_E_SHARING_VIOLATION = HResultCode.new('NS_E_SHARING_VIOLATION', 0xc00d0fcf, 'The file is already in use. Close other programs that might be using the file, or stop playing the file, and then try again.')

    # (0xc00d0fd0) Windows Media Player has encountered an unknown error.
    NS_E_NO_ERROR_STRING_FOUND = HResultCode.new('NS_E_NO_ERROR_STRING_FOUND', 0xc00d0fd0, 'Windows Media Player has encountered an unknown error.')

    # (0xc00d0fd1) The Windows Media Player ActiveX control cannot connect to remote media services, but will continue with local media services.
    NS_E_WMPOCX_NO_REMOTE_CORE = HResultCode.new('NS_E_WMPOCX_NO_REMOTE_CORE', 0xc00d0fd1, 'The Windows Media Player ActiveX control cannot connect to remote media services, but will continue with local media services.')

    # (0xc00d0fd2) The requested method or property is not available because the Windows Media Player ActiveX control has not been properly activated.
    NS_E_WMPOCX_NO_ACTIVE_CORE = HResultCode.new('NS_E_WMPOCX_NO_ACTIVE_CORE', 0xc00d0fd2, 'The requested method or property is not available because the Windows Media Player ActiveX control has not been properly activated.')

    # (0xc00d0fd3) The Windows Media Player ActiveX control is not running in remote mode.
    NS_E_WMPOCX_NOT_RUNNING_REMOTELY = HResultCode.new('NS_E_WMPOCX_NOT_RUNNING_REMOTELY', 0xc00d0fd3, 'The Windows Media Player ActiveX control is not running in remote mode.')

    # (0xc00d0fd4) An error occurred while trying to get the remote Windows Media Player window.
    NS_E_WMPOCX_NO_REMOTE_WINDOW = HResultCode.new('NS_E_WMPOCX_NO_REMOTE_WINDOW', 0xc00d0fd4, 'An error occurred while trying to get the remote Windows Media Player window.')

    # (0xc00d0fd5) Windows Media Player has encountered an unknown error.
    NS_E_WMPOCX_ERRORMANAGERNOTAVAILABLE = HResultCode.new('NS_E_WMPOCX_ERRORMANAGERNOTAVAILABLE', 0xc00d0fd5, 'Windows Media Player has encountered an unknown error.')

    # (0xc00d0fd6) Windows Media Player was not closed properly. A damaged or incompatible plug-in might have caused the problem to occur. As a precaution, all optional plug-ins have been disabled.
    NS_E_PLUGIN_NOTSHUTDOWN = HResultCode.new('NS_E_PLUGIN_NOTSHUTDOWN', 0xc00d0fd6, 'Windows Media Player was not closed properly. A damaged or incompatible plug-in might have caused the problem to occur. As a precaution, all optional plug-ins have been disabled.')

    # (0xc00d0fd7) Windows Media Player cannot find the specified path. Verify that the path is typed correctly. If it is, the path does not exist in the specified location, or the computer where the path is located is not available.
    NS_E_WMP_CANNOT_FIND_FOLDER = HResultCode.new('NS_E_WMP_CANNOT_FIND_FOLDER', 0xc00d0fd7, 'Windows Media Player cannot find the specified path. Verify that the path is typed correctly. If it is, the path does not exist in the specified location, or the computer where the path is located is not available.')

    # (0xc00d0fd8) Windows Media Player cannot save a file that is being streamed.
    NS_E_WMP_STREAMING_RECORDING_NOT_ALLOWED = HResultCode.new('NS_E_WMP_STREAMING_RECORDING_NOT_ALLOWED', 0xc00d0fd8, 'Windows Media Player cannot save a file that is being streamed.')

    # (0xc00d0fd9) Windows Media Player cannot find the selected plug-in. The Player will try to remove it from the menu. To use this plug-in, install it again.
    NS_E_WMP_PLUGINDLL_NOTFOUND = HResultCode.new('NS_E_WMP_PLUGINDLL_NOTFOUND', 0xc00d0fd9, 'Windows Media Player cannot find the selected plug-in. The Player will try to remove it from the menu. To use this plug-in, install it again.')

    # (0xc00d0fda) Action requires input from the user.
    NS_E_NEED_TO_ASK_USER = HResultCode.new('NS_E_NEED_TO_ASK_USER', 0xc00d0fda, 'Action requires input from the user.')

    # (0xc00d0fdb) The Windows Media Player ActiveX control must be in a docked state for this action to be performed.
    NS_E_WMPOCX_PLAYER_NOT_DOCKED = HResultCode.new('NS_E_WMPOCX_PLAYER_NOT_DOCKED', 0xc00d0fdb, 'The Windows Media Player ActiveX control must be in a docked state for this action to be performed.')

    # (0xc00d0fdc) The Windows Media Player external object is not ready.
    NS_E_WMP_EXTERNAL_NOTREADY = HResultCode.new('NS_E_WMP_EXTERNAL_NOTREADY', 0xc00d0fdc, 'The Windows Media Player external object is not ready.')

    # (0xc00d0fdd) Windows Media Player cannot perform the requested action. Your computer's time and date might not be set correctly.
    NS_E_WMP_MLS_STALE_DATA = HResultCode.new('NS_E_WMP_MLS_STALE_DATA', 0xc00d0fdd, 'Windows Media Player cannot perform the requested action. Your computer\'s time and date might not be set correctly.')

    # (0xc00d0fde) The control (%s) does not support creation of sub-controls, yet (%d) sub-controls have been specified.
    NS_E_WMP_UI_SUBCONTROLSNOTSUPPORTED = HResultCode.new('NS_E_WMP_UI_SUBCONTROLSNOTSUPPORTED', 0xc00d0fde, 'The control (%s) does not support creation of sub-controls, yet (%d) sub-controls have been specified.')

    # (0xc00d0fdf) Version mismatch: (%.1f required, %.1f found).
    NS_E_WMP_UI_VERSIONMISMATCH = HResultCode.new('NS_E_WMP_UI_VERSIONMISMATCH', 0xc00d0fdf, 'Version mismatch: (%.1f required, %.1f found).')

    # (0xc00d0fe0) The layout manager was given valid XML that wasn't a theme file.
    NS_E_WMP_UI_NOTATHEMEFILE = HResultCode.new('NS_E_WMP_UI_NOTATHEMEFILE', 0xc00d0fe0, 'The layout manager was given valid XML that wasn\'t a theme file.')

    # (0xc00d0fe1) The %s subelement could not be found on the %s object.
    NS_E_WMP_UI_SUBELEMENTNOTFOUND = HResultCode.new('NS_E_WMP_UI_SUBELEMENTNOTFOUND', 0xc00d0fe1, 'The %s subelement could not be found on the %s object.')

    # (0xc00d0fe2) An error occurred parsing the version tag. Valid version tags are of the form: <?wmp version='1.0'?>.
    NS_E_WMP_UI_VERSIONPARSE = HResultCode.new('NS_E_WMP_UI_VERSIONPARSE', 0xc00d0fe2, 'An error occurred parsing the version tag. Valid version tags are of the form: <?wmp version=\'1.0\'?>.')

    # (0xc00d0fe3) The view specified in for the 'currentViewID' property (%s) was not found in this theme file.
    NS_E_WMP_UI_VIEWIDNOTFOUND = HResultCode.new('NS_E_WMP_UI_VIEWIDNOTFOUND', 0xc00d0fe3, 'The view specified in for the \'currentViewID\' property (%s) was not found in this theme file.')

    # (0xc00d0fe4) This error used internally for hit testing.
    NS_E_WMP_UI_PASSTHROUGH = HResultCode.new('NS_E_WMP_UI_PASSTHROUGH', 0xc00d0fe4, 'This error used internally for hit testing.')

    # (0xc00d0fe5) Attributes were specified for the %s object, but the object was not available to send them to.
    NS_E_WMP_UI_OBJECTNOTFOUND = HResultCode.new('NS_E_WMP_UI_OBJECTNOTFOUND', 0xc00d0fe5, 'Attributes were specified for the %s object, but the object was not available to send them to.')

    # (0xc00d0fe6) The %s event already has a handler, the second handler was ignored.
    NS_E_WMP_UI_SECONDHANDLER = HResultCode.new('NS_E_WMP_UI_SECONDHANDLER', 0xc00d0fe6, 'The %s event already has a handler, the second handler was ignored.')

    # (0xc00d0fe7) No .wms file found in skin archive.
    NS_E_WMP_UI_NOSKININZIP = HResultCode.new('NS_E_WMP_UI_NOSKININZIP', 0xc00d0fe7, 'No .wms file found in skin archive.')

    # (0xc00d0fea) Windows Media Player encountered a problem while downloading the file. For additional assistance, click Web Help.
    NS_E_WMP_URLDOWNLOADFAILED = HResultCode.new('NS_E_WMP_URLDOWNLOADFAILED', 0xc00d0fea, 'Windows Media Player encountered a problem while downloading the file. For additional assistance, click Web Help.')

    # (0xc00d0feb) The Windows Media Player ActiveX control cannot load the requested uiMode and cannot roll back to the existing uiMode.
    NS_E_WMPOCX_UNABLE_TO_LOAD_SKIN = HResultCode.new('NS_E_WMPOCX_UNABLE_TO_LOAD_SKIN', 0xc00d0feb, 'The Windows Media Player ActiveX control cannot load the requested uiMode and cannot roll back to the existing uiMode.')

    # (0xc00d0fec) Windows Media Player encountered a problem with the skin file. The skin file might not be valid.
    NS_E_WMP_INVALID_SKIN = HResultCode.new('NS_E_WMP_INVALID_SKIN', 0xc00d0fec, 'Windows Media Player encountered a problem with the skin file. The skin file might not be valid.')

    # (0xc00d0fed) Windows Media Player cannot send the link because your email program is not responding. Verify that your email program is configured properly, and then try again. For more information about email, see Windows Help.
    NS_E_WMP_SENDMAILFAILED = HResultCode.new('NS_E_WMP_SENDMAILFAILED', 0xc00d0fed, 'Windows Media Player cannot send the link because your email program is not responding. Verify that your email program is configured properly, and then try again. For more information about email, see Windows Help.')

    # (0xc00d0fee) Windows Media Player cannot switch to full mode because your computer administrator has locked this skin.
    NS_E_WMP_LOCKEDINSKINMODE = HResultCode.new('NS_E_WMP_LOCKEDINSKINMODE', 0xc00d0fee, 'Windows Media Player cannot switch to full mode because your computer administrator has locked this skin.')

    # (0xc00d0fef) Windows Media Player encountered a problem while saving the file. For additional assistance, click Web Help.
    NS_E_WMP_FAILED_TO_SAVE_FILE = HResultCode.new('NS_E_WMP_FAILED_TO_SAVE_FILE', 0xc00d0fef, 'Windows Media Player encountered a problem while saving the file. For additional assistance, click Web Help.')

    # (0xc00d0ff0) Windows Media Player cannot overwrite a read-only file. Try using a different file name.
    NS_E_WMP_SAVEAS_READONLY = HResultCode.new('NS_E_WMP_SAVEAS_READONLY', 0xc00d0ff0, 'Windows Media Player cannot overwrite a read-only file. Try using a different file name.')

    # (0xc00d0ff1) Windows Media Player encountered a problem while creating or saving the playlist. For additional assistance, click Web Help.
    NS_E_WMP_FAILED_TO_SAVE_PLAYLIST = HResultCode.new('NS_E_WMP_FAILED_TO_SAVE_PLAYLIST', 0xc00d0ff1, 'Windows Media Player encountered a problem while creating or saving the playlist. For additional assistance, click Web Help.')

    # (0xc00d0ff2) Windows Media Player cannot open the Windows Media Download file. The file might be damaged.
    NS_E_WMP_FAILED_TO_OPEN_WMD = HResultCode.new('NS_E_WMP_FAILED_TO_OPEN_WMD', 0xc00d0ff2, 'Windows Media Player cannot open the Windows Media Download file. The file might be damaged.')

    # (0xc00d0ff3) The file cannot be added to the library because it is a protected DVR-MS file. This content cannot be played back by Windows Media Player.
    NS_E_WMP_CANT_PLAY_PROTECTED = HResultCode.new('NS_E_WMP_CANT_PLAY_PROTECTED', 0xc00d0ff3, 'The file cannot be added to the library because it is a protected DVR-MS file. This content cannot be played back by Windows Media Player.')

    # (0xc00d0ff4) Media sharing has been turned off because a required Windows setting or component has changed. For additional assistance, click Web Help.
    NS_E_SHARING_STATE_OUT_OF_SYNC = HResultCode.new('NS_E_SHARING_STATE_OUT_OF_SYNC', 0xc00d0ff4, 'Media sharing has been turned off because a required Windows setting or component has changed. For additional assistance, click Web Help.')

    # (0xc00d0ffa) Exclusive Services launch failed because the Windows Media Player is already running.
    NS_E_WMPOCX_REMOTE_PLAYER_ALREADY_RUNNING = HResultCode.new('NS_E_WMPOCX_REMOTE_PLAYER_ALREADY_RUNNING', 0xc00d0ffa, 'Exclusive Services launch failed because the Windows Media Player is already running.')

    # (0xc00d1004) JPG Images are not recommended for use as a mappingImage.
    NS_E_WMP_RBC_JPGMAPPINGIMAGE = HResultCode.new('NS_E_WMP_RBC_JPGMAPPINGIMAGE', 0xc00d1004, 'JPG Images are not recommended for use as a mappingImage.')

    # (0xc00d1005) JPG Images are not recommended when using a transparencyColor.
    NS_E_WMP_JPGTRANSPARENCY = HResultCode.new('NS_E_WMP_JPGTRANSPARENCY', 0xc00d1005, 'JPG Images are not recommended when using a transparencyColor.')

    # (0xc00d1009) The Max property cannot be less than Min property.
    NS_E_WMP_INVALID_MAX_VAL = HResultCode.new('NS_E_WMP_INVALID_MAX_VAL', 0xc00d1009, 'The Max property cannot be less than Min property.')

    # (0xc00d100a) The Min property cannot be greater than Max property.
    NS_E_WMP_INVALID_MIN_VAL = HResultCode.new('NS_E_WMP_INVALID_MIN_VAL', 0xc00d100a, 'The Min property cannot be greater than Max property.')

    # (0xc00d100e) JPG Images are not recommended for use as a positionImage.
    NS_E_WMP_CS_JPGPOSITIONIMAGE = HResultCode.new('NS_E_WMP_CS_JPGPOSITIONIMAGE', 0xc00d100e, 'JPG Images are not recommended for use as a positionImage.')

    # (0xc00d100f) The (%s) image's size is not evenly divisible by the positionImage's size.
    NS_E_WMP_CS_NOTEVENLYDIVISIBLE = HResultCode.new('NS_E_WMP_CS_NOTEVENLYDIVISIBLE', 0xc00d100f, 'The (%s) image\'s size is not evenly divisible by the positionImage\'s size.')

    # (0xc00d1018) The ZIP reader opened a file and its signature did not match that of the ZIP files.
    NS_E_WMPZIP_NOTAZIPFILE = HResultCode.new('NS_E_WMPZIP_NOTAZIPFILE', 0xc00d1018, 'The ZIP reader opened a file and its signature did not match that of the ZIP files.')

    # (0xc00d1019) The ZIP reader has detected that the file is corrupted.
    NS_E_WMPZIP_CORRUPT = HResultCode.new('NS_E_WMPZIP_CORRUPT', 0xc00d1019, 'The ZIP reader has detected that the file is corrupted.')

    # (0xc00d101a) GetFileStream, SaveToFile, or SaveTemp file was called on the ZIP reader with a file name that was not found in the ZIP file.
    NS_E_WMPZIP_FILENOTFOUND = HResultCode.new('NS_E_WMPZIP_FILENOTFOUND', 0xc00d101a, 'GetFileStream, SaveToFile, or SaveTemp file was called on the ZIP reader with a file name that was not found in the ZIP file.')

    # (0xc00d1022) Image type not supported.
    NS_E_WMP_IMAGE_FILETYPE_UNSUPPORTED = HResultCode.new('NS_E_WMP_IMAGE_FILETYPE_UNSUPPORTED', 0xc00d1022, 'Image type not supported.')

    # (0xc00d1023) Image file might be corrupt.
    NS_E_WMP_IMAGE_INVALID_FORMAT = HResultCode.new('NS_E_WMP_IMAGE_INVALID_FORMAT', 0xc00d1023, 'Image file might be corrupt.')

    # (0xc00d1024) Unexpected end of file. GIF file might be corrupt.
    NS_E_WMP_GIF_UNEXPECTED_ENDOFFILE = HResultCode.new('NS_E_WMP_GIF_UNEXPECTED_ENDOFFILE', 0xc00d1024, 'Unexpected end of file. GIF file might be corrupt.')

    # (0xc00d1025) Invalid GIF file.
    NS_E_WMP_GIF_INVALID_FORMAT = HResultCode.new('NS_E_WMP_GIF_INVALID_FORMAT', 0xc00d1025, 'Invalid GIF file.')

    # (0xc00d1026) Invalid GIF version. Only 87a or 89a supported.
    NS_E_WMP_GIF_BAD_VERSION_NUMBER = HResultCode.new('NS_E_WMP_GIF_BAD_VERSION_NUMBER', 0xc00d1026, 'Invalid GIF version. Only 87a or 89a supported.')

    # (0xc00d1027) No images found in GIF file.
    NS_E_WMP_GIF_NO_IMAGE_IN_FILE = HResultCode.new('NS_E_WMP_GIF_NO_IMAGE_IN_FILE', 0xc00d1027, 'No images found in GIF file.')

    # (0xc00d1028) Invalid PNG image file format.
    NS_E_WMP_PNG_INVALIDFORMAT = HResultCode.new('NS_E_WMP_PNG_INVALIDFORMAT', 0xc00d1028, 'Invalid PNG image file format.')

    # (0xc00d1029) PNG bitdepth not supported.
    NS_E_WMP_PNG_UNSUPPORTED_BITDEPTH = HResultCode.new('NS_E_WMP_PNG_UNSUPPORTED_BITDEPTH', 0xc00d1029, 'PNG bitdepth not supported.')

    # (0xc00d102a) Compression format defined in PNG file not supported,
    NS_E_WMP_PNG_UNSUPPORTED_COMPRESSION = HResultCode.new('NS_E_WMP_PNG_UNSUPPORTED_COMPRESSION', 0xc00d102a, 'Compression format defined in PNG file not supported,')

    # (0xc00d102b) Filter method defined in PNG file not supported.
    NS_E_WMP_PNG_UNSUPPORTED_FILTER = HResultCode.new('NS_E_WMP_PNG_UNSUPPORTED_FILTER', 0xc00d102b, 'Filter method defined in PNG file not supported.')

    # (0xc00d102c) Interlace method defined in PNG file not supported.
    NS_E_WMP_PNG_UNSUPPORTED_INTERLACE = HResultCode.new('NS_E_WMP_PNG_UNSUPPORTED_INTERLACE', 0xc00d102c, 'Interlace method defined in PNG file not supported.')

    # (0xc00d102d) Bad CRC in PNG file.
    NS_E_WMP_PNG_UNSUPPORTED_BAD_CRC = HResultCode.new('NS_E_WMP_PNG_UNSUPPORTED_BAD_CRC', 0xc00d102d, 'Bad CRC in PNG file.')

    # (0xc00d102e) Invalid bitmask in BMP file.
    NS_E_WMP_BMP_INVALID_BITMASK = HResultCode.new('NS_E_WMP_BMP_INVALID_BITMASK', 0xc00d102e, 'Invalid bitmask in BMP file.')

    # (0xc00d102f) Topdown DIB not supported.
    NS_E_WMP_BMP_TOPDOWN_DIB_UNSUPPORTED = HResultCode.new('NS_E_WMP_BMP_TOPDOWN_DIB_UNSUPPORTED', 0xc00d102f, 'Topdown DIB not supported.')

    # (0xc00d1030) Bitmap could not be created.
    NS_E_WMP_BMP_BITMAP_NOT_CREATED = HResultCode.new('NS_E_WMP_BMP_BITMAP_NOT_CREATED', 0xc00d1030, 'Bitmap could not be created.')

    # (0xc00d1031) Compression format defined in BMP not supported.
    NS_E_WMP_BMP_COMPRESSION_UNSUPPORTED = HResultCode.new('NS_E_WMP_BMP_COMPRESSION_UNSUPPORTED', 0xc00d1031, 'Compression format defined in BMP not supported.')

    # (0xc00d1032) Invalid Bitmap format.
    NS_E_WMP_BMP_INVALID_FORMAT = HResultCode.new('NS_E_WMP_BMP_INVALID_FORMAT', 0xc00d1032, 'Invalid Bitmap format.')

    # (0xc00d1033) JPEG Arithmetic coding not supported.
    NS_E_WMP_JPG_JERR_ARITHCODING_NOTIMPL = HResultCode.new('NS_E_WMP_JPG_JERR_ARITHCODING_NOTIMPL', 0xc00d1033, 'JPEG Arithmetic coding not supported.')

    # (0xc00d1034) Invalid JPEG format.
    NS_E_WMP_JPG_INVALID_FORMAT = HResultCode.new('NS_E_WMP_JPG_INVALID_FORMAT', 0xc00d1034, 'Invalid JPEG format.')

    # (0xc00d1035) Invalid JPEG format.
    NS_E_WMP_JPG_BAD_DCTSIZE = HResultCode.new('NS_E_WMP_JPG_BAD_DCTSIZE', 0xc00d1035, 'Invalid JPEG format.')

    # (0xc00d1036) Internal version error. Unexpected JPEG library version.
    NS_E_WMP_JPG_BAD_VERSION_NUMBER = HResultCode.new('NS_E_WMP_JPG_BAD_VERSION_NUMBER', 0xc00d1036, 'Internal version error. Unexpected JPEG library version.')

    # (0xc00d1037) Internal JPEG Library error. Unsupported JPEG data precision.
    NS_E_WMP_JPG_BAD_PRECISION = HResultCode.new('NS_E_WMP_JPG_BAD_PRECISION', 0xc00d1037, 'Internal JPEG Library error. Unsupported JPEG data precision.')

    # (0xc00d1038) JPEG CCIR601 not supported.
    NS_E_WMP_JPG_CCIR601_NOTIMPL = HResultCode.new('NS_E_WMP_JPG_CCIR601_NOTIMPL', 0xc00d1038, 'JPEG CCIR601 not supported.')

    # (0xc00d1039) No image found in JPEG file.
    NS_E_WMP_JPG_NO_IMAGE_IN_FILE = HResultCode.new('NS_E_WMP_JPG_NO_IMAGE_IN_FILE', 0xc00d1039, 'No image found in JPEG file.')

    # (0xc00d103a) Could not read JPEG file.
    NS_E_WMP_JPG_READ_ERROR = HResultCode.new('NS_E_WMP_JPG_READ_ERROR', 0xc00d103a, 'Could not read JPEG file.')

    # (0xc00d103b) JPEG Fractional sampling not supported.
    NS_E_WMP_JPG_FRACT_SAMPLE_NOTIMPL = HResultCode.new('NS_E_WMP_JPG_FRACT_SAMPLE_NOTIMPL', 0xc00d103b, 'JPEG Fractional sampling not supported.')

    # (0xc00d103c) JPEG image too large. Maximum image size supported is 65500 X 65500.
    NS_E_WMP_JPG_IMAGE_TOO_BIG = HResultCode.new('NS_E_WMP_JPG_IMAGE_TOO_BIG', 0xc00d103c, 'JPEG image too large. Maximum image size supported is 65500 X 65500.')

    # (0xc00d103d) Unexpected end of file reached in JPEG file.
    NS_E_WMP_JPG_UNEXPECTED_ENDOFFILE = HResultCode.new('NS_E_WMP_JPG_UNEXPECTED_ENDOFFILE', 0xc00d103d, 'Unexpected end of file reached in JPEG file.')

    # (0xc00d103e) Unsupported JPEG SOF marker found.
    NS_E_WMP_JPG_SOF_UNSUPPORTED = HResultCode.new('NS_E_WMP_JPG_SOF_UNSUPPORTED', 0xc00d103e, 'Unsupported JPEG SOF marker found.')

    # (0xc00d103f) Unknown JPEG marker found.
    NS_E_WMP_JPG_UNKNOWN_MARKER = HResultCode.new('NS_E_WMP_JPG_UNKNOWN_MARKER', 0xc00d103f, 'Unknown JPEG marker found.')

    # (0xc00d1044) Windows Media Player cannot display the picture file. The player either does not support the picture type or the picture is corrupted.
    NS_E_WMP_FAILED_TO_OPEN_IMAGE = HResultCode.new('NS_E_WMP_FAILED_TO_OPEN_IMAGE', 0xc00d1044, 'Windows Media Player cannot display the picture file. The player either does not support the picture type or the picture is corrupted.')

    # (0xc00d1049) Windows Media Player cannot compute a Digital Audio Id for the song. It is too short.
    NS_E_WMP_DAI_SONGTOOSHORT = HResultCode.new('NS_E_WMP_DAI_SONGTOOSHORT', 0xc00d1049, 'Windows Media Player cannot compute a Digital Audio Id for the song. It is too short.')

    # (0xc00d104a) Windows Media Player cannot play the file at the requested speed.
    NS_E_WMG_RATEUNAVAILABLE = HResultCode.new('NS_E_WMG_RATEUNAVAILABLE', 0xc00d104a, 'Windows Media Player cannot play the file at the requested speed.')

    # (0xc00d104b) The rendering or digital signal processing plug-in cannot be instantiated.
    NS_E_WMG_PLUGINUNAVAILABLE = HResultCode.new('NS_E_WMG_PLUGINUNAVAILABLE', 0xc00d104b, 'The rendering or digital signal processing plug-in cannot be instantiated.')

    # (0xc00d104c) The file cannot be queued for seamless playback.
    NS_E_WMG_CANNOTQUEUE = HResultCode.new('NS_E_WMG_CANNOTQUEUE', 0xc00d104c, 'The file cannot be queued for seamless playback.')

    # (0xc00d104d) Windows Media Player cannot download media usage rights for a file in the playlist.
    NS_E_WMG_PREROLLLICENSEACQUISITIONNOTALLOWED = HResultCode.new('NS_E_WMG_PREROLLLICENSEACQUISITIONNOTALLOWED', 0xc00d104d, 'Windows Media Player cannot download media usage rights for a file in the playlist.')

    # (0xc00d104e) Windows Media Player encountered an error while trying to queue a file.
    NS_E_WMG_UNEXPECTEDPREROLLSTATUS = HResultCode.new('NS_E_WMG_UNEXPECTEDPREROLLSTATUS', 0xc00d104e, 'Windows Media Player encountered an error while trying to queue a file.')

    # (0xc00d1051) Windows Media Player cannot play the protected file. The Player cannot verify that the connection to your video card is secure. Try installing an updated device driver for your video card.
    NS_E_WMG_INVALID_COPP_CERTIFICATE = HResultCode.new('NS_E_WMG_INVALID_COPP_CERTIFICATE', 0xc00d1051, 'Windows Media Player cannot play the protected file. The Player cannot verify that the connection to your video card is secure. Try installing an updated device driver for your video card.')

    # (0xc00d1052) Windows Media Player cannot play the protected file. The Player detected that the connection to your hardware might not be secure.
    NS_E_WMG_COPP_SECURITY_INVALID = HResultCode.new('NS_E_WMG_COPP_SECURITY_INVALID', 0xc00d1052, 'Windows Media Player cannot play the protected file. The Player detected that the connection to your hardware might not be secure.')

    # (0xc00d1053) Windows Media Player output link protection is unsupported on this system.
    NS_E_WMG_COPP_UNSUPPORTED = HResultCode.new('NS_E_WMG_COPP_UNSUPPORTED', 0xc00d1053, 'Windows Media Player output link protection is unsupported on this system.')

    # (0xc00d1054) Operation attempted in an invalid graph state.
    NS_E_WMG_INVALIDSTATE = HResultCode.new('NS_E_WMG_INVALIDSTATE', 0xc00d1054, 'Operation attempted in an invalid graph state.')

    # (0xc00d1055) A renderer cannot be inserted in a stream while one already exists.
    NS_E_WMG_SINKALREADYEXISTS = HResultCode.new('NS_E_WMG_SINKALREADYEXISTS', 0xc00d1055, 'A renderer cannot be inserted in a stream while one already exists.')

    # (0xc00d1056) The Windows Media SDK interface needed to complete the operation does not exist at this time.
    NS_E_WMG_NOSDKINTERFACE = HResultCode.new('NS_E_WMG_NOSDKINTERFACE', 0xc00d1056, 'The Windows Media SDK interface needed to complete the operation does not exist at this time.')

    # (0xc00d1057) Windows Media Player cannot play a portion of the file because it requires a codec that either could not be downloaded or that is not supported by the Player.
    NS_E_WMG_NOTALLOUTPUTSRENDERED = HResultCode.new('NS_E_WMG_NOTALLOUTPUTSRENDERED', 0xc00d1057, 'Windows Media Player cannot play a portion of the file because it requires a codec that either could not be downloaded or that is not supported by the Player.')

    # (0xc00d1058) File transfer streams are not allowed in the standalone Player.
    NS_E_WMG_FILETRANSFERNOTALLOWED = HResultCode.new('NS_E_WMG_FILETRANSFERNOTALLOWED', 0xc00d1058, 'File transfer streams are not allowed in the standalone Player.')

    # (0xc00d1059) Windows Media Player cannot play the file. The Player does not support the format you are trying to play.
    NS_E_WMR_UNSUPPORTEDSTREAM = HResultCode.new('NS_E_WMR_UNSUPPORTEDSTREAM', 0xc00d1059, 'Windows Media Player cannot play the file. The Player does not support the format you are trying to play.')

    # (0xc00d105a) An operation was attempted on a pin that does not exist in the DirectShow filter graph.
    NS_E_WMR_PINNOTFOUND = HResultCode.new('NS_E_WMR_PINNOTFOUND', 0xc00d105a, 'An operation was attempted on a pin that does not exist in the DirectShow filter graph.')

    # (0xc00d105b) Specified operation cannot be completed while waiting for a media format change from the SDK.
    NS_E_WMR_WAITINGONFORMATSWITCH = HResultCode.new('NS_E_WMR_WAITINGONFORMATSWITCH', 0xc00d105b, 'Specified operation cannot be completed while waiting for a media format change from the SDK.')

    # (0xc00d105c) Specified operation cannot be completed because the source filter does not exist.
    NS_E_WMR_NOSOURCEFILTER = HResultCode.new('NS_E_WMR_NOSOURCEFILTER', 0xc00d105c, 'Specified operation cannot be completed because the source filter does not exist.')

    # (0xc00d105d) The specified type does not match this pin.
    NS_E_WMR_PINTYPENOMATCH = HResultCode.new('NS_E_WMR_PINTYPENOMATCH', 0xc00d105d, 'The specified type does not match this pin.')

    # (0xc00d105e) The WMR Source Filter does not have a callback available.
    NS_E_WMR_NOCALLBACKAVAILABLE = HResultCode.new('NS_E_WMR_NOCALLBACKAVAILABLE', 0xc00d105e, 'The WMR Source Filter does not have a callback available.')

    # (0xc00d1062) The specified property has not been set on this sample.
    NS_E_WMR_SAMPLEPROPERTYNOTSET = HResultCode.new('NS_E_WMR_SAMPLEPROPERTYNOTSET', 0xc00d1062, 'The specified property has not been set on this sample.')

    # (0xc00d1063) A plug-in is required to correctly play the file. To determine if the plug-in is available to download, click Web Help.
    NS_E_WMR_CANNOT_RENDER_BINARY_STREAM = HResultCode.new('NS_E_WMR_CANNOT_RENDER_BINARY_STREAM', 0xc00d1063, 'A plug-in is required to correctly play the file. To determine if the plug-in is available to download, click Web Help.')

    # (0xc00d1064) Windows Media Player cannot play the file because your media usage rights are corrupted. If you previously backed up your media usage rights, try restoring them.
    NS_E_WMG_LICENSE_TAMPERED = HResultCode.new('NS_E_WMG_LICENSE_TAMPERED', 0xc00d1064, 'Windows Media Player cannot play the file because your media usage rights are corrupted. If you previously backed up your media usage rights, try restoring them.')

    # (0xc00d1065) Windows Media Player cannot play protected files that contain binary streams.
    NS_E_WMR_WILLNOT_RENDER_BINARY_STREAM = HResultCode.new('NS_E_WMR_WILLNOT_RENDER_BINARY_STREAM', 0xc00d1065, 'Windows Media Player cannot play protected files that contain binary streams.')

    # (0xc00d1068) Windows Media Player cannot play the playlist because it is not valid.
    NS_E_WMX_UNRECOGNIZED_PLAYLIST_FORMAT = HResultCode.new('NS_E_WMX_UNRECOGNIZED_PLAYLIST_FORMAT', 0xc00d1068, 'Windows Media Player cannot play the playlist because it is not valid.')

    # (0xc00d1069) Windows Media Player cannot play the playlist because it is not valid.
    NS_E_ASX_INVALIDFORMAT = HResultCode.new('NS_E_ASX_INVALIDFORMAT', 0xc00d1069, 'Windows Media Player cannot play the playlist because it is not valid.')

    # (0xc00d106a) A later version of Windows Media Player might be required to play this playlist.
    NS_E_ASX_INVALIDVERSION = HResultCode.new('NS_E_ASX_INVALIDVERSION', 0xc00d106a, 'A later version of Windows Media Player might be required to play this playlist.')

    # (0xc00d106b) The format of a REPEAT loop within the current playlist file is not valid.
    NS_E_ASX_INVALID_REPEAT_BLOCK = HResultCode.new('NS_E_ASX_INVALID_REPEAT_BLOCK', 0xc00d106b, 'The format of a REPEAT loop within the current playlist file is not valid.')

    # (0xc00d106c) Windows Media Player cannot save the playlist because it does not contain any items.
    NS_E_ASX_NOTHING_TO_WRITE = HResultCode.new('NS_E_ASX_NOTHING_TO_WRITE', 0xc00d106c, 'Windows Media Player cannot save the playlist because it does not contain any items.')

    # (0xc00d106d) Windows Media Player cannot play the playlist because it is not valid.
    NS_E_URLLIST_INVALIDFORMAT = HResultCode.new('NS_E_URLLIST_INVALIDFORMAT', 0xc00d106d, 'Windows Media Player cannot play the playlist because it is not valid.')

    # (0xc00d106e) The specified attribute does not exist.
    NS_E_WMX_ATTRIBUTE_DOES_NOT_EXIST = HResultCode.new('NS_E_WMX_ATTRIBUTE_DOES_NOT_EXIST', 0xc00d106e, 'The specified attribute does not exist.')

    # (0xc00d106f) The specified attribute already exists.
    NS_E_WMX_ATTRIBUTE_ALREADY_EXISTS = HResultCode.new('NS_E_WMX_ATTRIBUTE_ALREADY_EXISTS', 0xc00d106f, 'The specified attribute already exists.')

    # (0xc00d1070) Cannot retrieve the specified attribute.
    NS_E_WMX_ATTRIBUTE_UNRETRIEVABLE = HResultCode.new('NS_E_WMX_ATTRIBUTE_UNRETRIEVABLE', 0xc00d1070, 'Cannot retrieve the specified attribute.')

    # (0xc00d1071) The specified item does not exist in the current playlist.
    NS_E_WMX_ITEM_DOES_NOT_EXIST = HResultCode.new('NS_E_WMX_ITEM_DOES_NOT_EXIST', 0xc00d1071, 'The specified item does not exist in the current playlist.')

    # (0xc00d1072) Items of the specified type cannot be created within the current playlist.
    NS_E_WMX_ITEM_TYPE_ILLEGAL = HResultCode.new('NS_E_WMX_ITEM_TYPE_ILLEGAL', 0xc00d1072, 'Items of the specified type cannot be created within the current playlist.')

    # (0xc00d1073) The specified item cannot be set in the current playlist.
    NS_E_WMX_ITEM_UNSETTABLE = HResultCode.new('NS_E_WMX_ITEM_UNSETTABLE', 0xc00d1073, 'The specified item cannot be set in the current playlist.')

    # (0xc00d1074) Windows Media Player cannot perform the requested action because the playlist does not contain any items.
    NS_E_WMX_PLAYLIST_EMPTY = HResultCode.new('NS_E_WMX_PLAYLIST_EMPTY', 0xc00d1074, 'Windows Media Player cannot perform the requested action because the playlist does not contain any items.')

    # (0xc00d1075) The specified auto playlist contains a filter type that is either not valid or is not installed on this computer.
    NS_E_MLS_SMARTPLAYLIST_FILTER_NOT_REGISTERED = HResultCode.new('NS_E_MLS_SMARTPLAYLIST_FILTER_NOT_REGISTERED', 0xc00d1075, 'The specified auto playlist contains a filter type that is either not valid or is not installed on this computer.')

    # (0xc00d1076) Windows Media Player cannot play the file because the associated playlist contains too many nested playlists.
    NS_E_WMX_INVALID_FORMAT_OVER_NESTING = HResultCode.new('NS_E_WMX_INVALID_FORMAT_OVER_NESTING', 0xc00d1076, 'Windows Media Player cannot play the file because the associated playlist contains too many nested playlists.')

    # (0xc00d107c) Windows Media Player cannot find the file. Verify that the path is typed correctly. If it is, the file might not exist in the specified location, or the computer where the file is stored might not be available.
    NS_E_WMPCORE_NOSOURCEURLSTRING = HResultCode.new('NS_E_WMPCORE_NOSOURCEURLSTRING', 0xc00d107c, 'Windows Media Player cannot find the file. Verify that the path is typed correctly. If it is, the file might not exist in the specified location, or the computer where the file is stored might not be available.')

    # (0xc00d107d) Failed to create the Global Interface Table.
    NS_E_WMPCORE_COCREATEFAILEDFORGITOBJECT = HResultCode.new('NS_E_WMPCORE_COCREATEFAILEDFORGITOBJECT', 0xc00d107d, 'Failed to create the Global Interface Table.')

    # (0xc00d107e) Failed to get the marshaled graph event handler interface.
    NS_E_WMPCORE_FAILEDTOGETMARSHALLEDEVENTHANDLERINTERFACE = HResultCode.new('NS_E_WMPCORE_FAILEDTOGETMARSHALLEDEVENTHANDLERINTERFACE', 0xc00d107e, 'Failed to get the marshaled graph event handler interface.')

    # (0xc00d107f) Buffer is too small for copying media type.
    NS_E_WMPCORE_BUFFERTOOSMALL = HResultCode.new('NS_E_WMPCORE_BUFFERTOOSMALL', 0xc00d107f, 'Buffer is too small for copying media type.')

    # (0xc00d1080) The current state of the Player does not allow this operation.
    NS_E_WMPCORE_UNAVAILABLE = HResultCode.new('NS_E_WMPCORE_UNAVAILABLE', 0xc00d1080, 'The current state of the Player does not allow this operation.')

    # (0xc00d1081) The playlist manager does not understand the current play mode (for example, shuffle or normal).
    NS_E_WMPCORE_INVALIDPLAYLISTMODE = HResultCode.new('NS_E_WMPCORE_INVALIDPLAYLISTMODE', 0xc00d1081, 'The playlist manager does not understand the current play mode (for example, shuffle or normal).')

    # (0xc00d1086) Windows Media Player cannot play the file because it is not in the current playlist.
    NS_E_WMPCORE_ITEMNOTINPLAYLIST = HResultCode.new('NS_E_WMPCORE_ITEMNOTINPLAYLIST', 0xc00d1086, 'Windows Media Player cannot play the file because it is not in the current playlist.')

    # (0xc00d1087) There are no items in the playlist. Add items to the playlist, and then try again.
    NS_E_WMPCORE_PLAYLISTEMPTY = HResultCode.new('NS_E_WMPCORE_PLAYLISTEMPTY', 0xc00d1087, 'There are no items in the playlist. Add items to the playlist, and then try again.')

    # (0xc00d1088) The web page cannot be displayed because no web browser is installed on your computer.
    NS_E_WMPCORE_NOBROWSER = HResultCode.new('NS_E_WMPCORE_NOBROWSER', 0xc00d1088, 'The web page cannot be displayed because no web browser is installed on your computer.')

    # (0xc00d1089) Windows Media Player cannot find the specified file. Verify the path is typed correctly. If it is, the file does not exist in the specified location, or the computer where the file is stored is not available.
    NS_E_WMPCORE_UNRECOGNIZED_MEDIA_URL = HResultCode.new('NS_E_WMPCORE_UNRECOGNIZED_MEDIA_URL', 0xc00d1089, 'Windows Media Player cannot find the specified file. Verify the path is typed correctly. If it is, the file does not exist in the specified location, or the computer where the file is stored is not available.')

    # (0xc00d108a) Graph with the specified URL was not found in the prerolled graph list.
    NS_E_WMPCORE_GRAPH_NOT_IN_LIST = HResultCode.new('NS_E_WMPCORE_GRAPH_NOT_IN_LIST', 0xc00d108a, 'Graph with the specified URL was not found in the prerolled graph list.')

    # (0xc00d108b) Windows Media Player cannot perform the requested operation because there is only one item in the playlist.
    NS_E_WMPCORE_PLAYLIST_EMPTY_OR_SINGLE_MEDIA = HResultCode.new('NS_E_WMPCORE_PLAYLIST_EMPTY_OR_SINGLE_MEDIA', 0xc00d108b, 'Windows Media Player cannot perform the requested operation because there is only one item in the playlist.')

    # (0xc00d108c) An error sink was never registered for the calling object.
    NS_E_WMPCORE_ERRORSINKNOTREGISTERED = HResultCode.new('NS_E_WMPCORE_ERRORSINKNOTREGISTERED', 0xc00d108c, 'An error sink was never registered for the calling object.')

    # (0xc00d108d) The error manager is not available to respond to errors.
    NS_E_WMPCORE_ERRORMANAGERNOTAVAILABLE = HResultCode.new('NS_E_WMPCORE_ERRORMANAGERNOTAVAILABLE', 0xc00d108d, 'The error manager is not available to respond to errors.')

    # (0xc00d108e) The Web Help URL cannot be opened.
    NS_E_WMPCORE_WEBHELPFAILED = HResultCode.new('NS_E_WMPCORE_WEBHELPFAILED', 0xc00d108e, 'The Web Help URL cannot be opened.')

    # (0xc00d108f) Could not resume playing next item in playlist.
    NS_E_WMPCORE_MEDIA_ERROR_RESUME_FAILED = HResultCode.new('NS_E_WMPCORE_MEDIA_ERROR_RESUME_FAILED', 0xc00d108f, 'Could not resume playing next item in playlist.')

    # (0xc00d1090) Windows Media Player cannot play the file because the associated playlist does not contain any items or the playlist is not valid.
    NS_E_WMPCORE_NO_REF_IN_ENTRY = HResultCode.new('NS_E_WMPCORE_NO_REF_IN_ENTRY', 0xc00d1090, 'Windows Media Player cannot play the file because the associated playlist does not contain any items or the playlist is not valid.')

    # (0xc00d1091) An empty string for playlist attribute name was found.
    NS_E_WMPCORE_WMX_LIST_ATTRIBUTE_NAME_EMPTY = HResultCode.new('NS_E_WMPCORE_WMX_LIST_ATTRIBUTE_NAME_EMPTY', 0xc00d1091, 'An empty string for playlist attribute name was found.')

    # (0xc00d1092) A playlist attribute name that is not valid was found.
    NS_E_WMPCORE_WMX_LIST_ATTRIBUTE_NAME_ILLEGAL = HResultCode.new('NS_E_WMPCORE_WMX_LIST_ATTRIBUTE_NAME_ILLEGAL', 0xc00d1092, 'A playlist attribute name that is not valid was found.')

    # (0xc00d1093) An empty string for a playlist attribute value was found.
    NS_E_WMPCORE_WMX_LIST_ATTRIBUTE_VALUE_EMPTY = HResultCode.new('NS_E_WMPCORE_WMX_LIST_ATTRIBUTE_VALUE_EMPTY', 0xc00d1093, 'An empty string for a playlist attribute value was found.')

    # (0xc00d1094) An illegal value for a playlist attribute was found.
    NS_E_WMPCORE_WMX_LIST_ATTRIBUTE_VALUE_ILLEGAL = HResultCode.new('NS_E_WMPCORE_WMX_LIST_ATTRIBUTE_VALUE_ILLEGAL', 0xc00d1094, 'An illegal value for a playlist attribute was found.')

    # (0xc00d1095) An empty string for a playlist item attribute name was found.
    NS_E_WMPCORE_WMX_LIST_ITEM_ATTRIBUTE_NAME_EMPTY = HResultCode.new('NS_E_WMPCORE_WMX_LIST_ITEM_ATTRIBUTE_NAME_EMPTY', 0xc00d1095, 'An empty string for a playlist item attribute name was found.')

    # (0xc00d1096) An illegal value for a playlist item attribute name was found.
    NS_E_WMPCORE_WMX_LIST_ITEM_ATTRIBUTE_NAME_ILLEGAL = HResultCode.new('NS_E_WMPCORE_WMX_LIST_ITEM_ATTRIBUTE_NAME_ILLEGAL', 0xc00d1096, 'An illegal value for a playlist item attribute name was found.')

    # (0xc00d1097) An illegal value for a playlist item attribute was found.
    NS_E_WMPCORE_WMX_LIST_ITEM_ATTRIBUTE_VALUE_EMPTY = HResultCode.new('NS_E_WMPCORE_WMX_LIST_ITEM_ATTRIBUTE_VALUE_EMPTY', 0xc00d1097, 'An illegal value for a playlist item attribute was found.')

    # (0xc00d1098) The playlist does not contain any items.
    NS_E_WMPCORE_LIST_ENTRY_NO_REF = HResultCode.new('NS_E_WMPCORE_LIST_ENTRY_NO_REF', 0xc00d1098, 'The playlist does not contain any items.')

    # (0xc00d1099) Windows Media Player cannot play the file. The file is either corrupted or the Player does not support the format you are trying to play.
    NS_E_WMPCORE_MISNAMED_FILE = HResultCode.new('NS_E_WMPCORE_MISNAMED_FILE', 0xc00d1099, 'Windows Media Player cannot play the file. The file is either corrupted or the Player does not support the format you are trying to play.')

    # (0xc00d109a) The codec downloaded for this file does not appear to be properly signed, so it cannot be installed.
    NS_E_WMPCORE_CODEC_NOT_TRUSTED = HResultCode.new('NS_E_WMPCORE_CODEC_NOT_TRUSTED', 0xc00d109a, 'The codec downloaded for this file does not appear to be properly signed, so it cannot be installed.')

    # (0xc00d109b) Windows Media Player cannot play the file. One or more codecs required to play the file could not be found.
    NS_E_WMPCORE_CODEC_NOT_FOUND = HResultCode.new('NS_E_WMPCORE_CODEC_NOT_FOUND', 0xc00d109b, 'Windows Media Player cannot play the file. One or more codecs required to play the file could not be found.')

    # (0xc00d109c) Windows Media Player cannot play the file because a required codec is not installed on your computer. To try downloading the codec, turn on the "Download codecs automatically" option.
    NS_E_WMPCORE_CODEC_DOWNLOAD_NOT_ALLOWED = HResultCode.new('NS_E_WMPCORE_CODEC_DOWNLOAD_NOT_ALLOWED', 0xc00d109c, 'Windows Media Player cannot play the file because a required codec is not installed on your computer. To try downloading the codec, turn on the "Download codecs automatically" option.')

    # (0xc00d109d) Windows Media Player encountered a problem while downloading the playlist. For additional assistance, click Web Help.
    NS_E_WMPCORE_ERROR_DOWNLOADING_PLAYLIST = HResultCode.new('NS_E_WMPCORE_ERROR_DOWNLOADING_PLAYLIST', 0xc00d109d, 'Windows Media Player encountered a problem while downloading the playlist. For additional assistance, click Web Help.')

    # (0xc00d109e) Failed to build the playlist.
    NS_E_WMPCORE_FAILED_TO_BUILD_PLAYLIST = HResultCode.new('NS_E_WMPCORE_FAILED_TO_BUILD_PLAYLIST', 0xc00d109e, 'Failed to build the playlist.')

    # (0xc00d109f) Playlist has no alternates to switch into.
    NS_E_WMPCORE_PLAYLIST_ITEM_ALTERNATE_NONE = HResultCode.new('NS_E_WMPCORE_PLAYLIST_ITEM_ALTERNATE_NONE', 0xc00d109f, 'Playlist has no alternates to switch into.')

    # (0xc00d10a0) No more playlist alternates available to switch to.
    NS_E_WMPCORE_PLAYLIST_ITEM_ALTERNATE_EXHAUSTED = HResultCode.new('NS_E_WMPCORE_PLAYLIST_ITEM_ALTERNATE_EXHAUSTED', 0xc00d10a0, 'No more playlist alternates available to switch to.')

    # (0xc00d10a1) Could not find the name of the alternate playlist to switch into.
    NS_E_WMPCORE_PLAYLIST_ITEM_ALTERNATE_NAME_NOT_FOUND = HResultCode.new('NS_E_WMPCORE_PLAYLIST_ITEM_ALTERNATE_NAME_NOT_FOUND', 0xc00d10a1, 'Could not find the name of the alternate playlist to switch into.')

    # (0xc00d10a2) Failed to switch to an alternate for this media.
    NS_E_WMPCORE_PLAYLIST_ITEM_ALTERNATE_MORPH_FAILED = HResultCode.new('NS_E_WMPCORE_PLAYLIST_ITEM_ALTERNATE_MORPH_FAILED', 0xc00d10a2, 'Failed to switch to an alternate for this media.')

    # (0xc00d10a3) Failed to initialize an alternate for the media.
    NS_E_WMPCORE_PLAYLIST_ITEM_ALTERNATE_INIT_FAILED = HResultCode.new('NS_E_WMPCORE_PLAYLIST_ITEM_ALTERNATE_INIT_FAILED', 0xc00d10a3, 'Failed to initialize an alternate for the media.')

    # (0xc00d10a4) No URL specified for the roll over Refs in the playlist file.
    NS_E_WMPCORE_MEDIA_ALTERNATE_REF_EMPTY = HResultCode.new('NS_E_WMPCORE_MEDIA_ALTERNATE_REF_EMPTY', 0xc00d10a4, 'No URL specified for the roll over Refs in the playlist file.')

    # (0xc00d10a5) Encountered a playlist with no name.
    NS_E_WMPCORE_PLAYLIST_NO_EVENT_NAME = HResultCode.new('NS_E_WMPCORE_PLAYLIST_NO_EVENT_NAME', 0xc00d10a5, 'Encountered a playlist with no name.')

    # (0xc00d10a6) A required attribute in the event block of the playlist was not found.
    NS_E_WMPCORE_PLAYLIST_EVENT_ATTRIBUTE_ABSENT = HResultCode.new('NS_E_WMPCORE_PLAYLIST_EVENT_ATTRIBUTE_ABSENT', 0xc00d10a6, 'A required attribute in the event block of the playlist was not found.')

    # (0xc00d10a7) No items were found in the event block of the playlist.
    NS_E_WMPCORE_PLAYLIST_EVENT_EMPTY = HResultCode.new('NS_E_WMPCORE_PLAYLIST_EVENT_EMPTY', 0xc00d10a7, 'No items were found in the event block of the playlist.')

    # (0xc00d10a8) No playlist was found while returning from a nested playlist.
    NS_E_WMPCORE_PLAYLIST_STACK_EMPTY = HResultCode.new('NS_E_WMPCORE_PLAYLIST_STACK_EMPTY', 0xc00d10a8, 'No playlist was found while returning from a nested playlist.')

    # (0xc00d10a9) The media item is not active currently.
    NS_E_WMPCORE_CURRENT_MEDIA_NOT_ACTIVE = HResultCode.new('NS_E_WMPCORE_CURRENT_MEDIA_NOT_ACTIVE', 0xc00d10a9, 'The media item is not active currently.')

    # (0xc00d10ab) Windows Media Player cannot perform the requested action because you chose to cancel it.
    NS_E_WMPCORE_USER_CANCEL = HResultCode.new('NS_E_WMPCORE_USER_CANCEL', 0xc00d10ab, 'Windows Media Player cannot perform the requested action because you chose to cancel it.')

    # (0xc00d10ac) Windows Media Player encountered a problem with the playlist. The format of the playlist is not valid.
    NS_E_WMPCORE_PLAYLIST_REPEAT_EMPTY = HResultCode.new('NS_E_WMPCORE_PLAYLIST_REPEAT_EMPTY', 0xc00d10ac, 'Windows Media Player encountered a problem with the playlist. The format of the playlist is not valid.')

    # (0xc00d10ad) Media object corresponding to start of a playlist repeat block was not found.
    NS_E_WMPCORE_PLAYLIST_REPEAT_START_MEDIA_NONE = HResultCode.new('NS_E_WMPCORE_PLAYLIST_REPEAT_START_MEDIA_NONE', 0xc00d10ad, 'Media object corresponding to start of a playlist repeat block was not found.')

    # (0xc00d10ae) Media object corresponding to the end of a playlist repeat block was not found.
    NS_E_WMPCORE_PLAYLIST_REPEAT_END_MEDIA_NONE = HResultCode.new('NS_E_WMPCORE_PLAYLIST_REPEAT_END_MEDIA_NONE', 0xc00d10ae, 'Media object corresponding to the end of a playlist repeat block was not found.')

    # (0xc00d10af) The playlist URL supplied to the playlist manager is not valid.
    NS_E_WMPCORE_INVALID_PLAYLIST_URL = HResultCode.new('NS_E_WMPCORE_INVALID_PLAYLIST_URL', 0xc00d10af, 'The playlist URL supplied to the playlist manager is not valid.')

    # (0xc00d10b0) Windows Media Player cannot play the file because it is corrupted.
    NS_E_WMPCORE_MISMATCHED_RUNTIME = HResultCode.new('NS_E_WMPCORE_MISMATCHED_RUNTIME', 0xc00d10b0, 'Windows Media Player cannot play the file because it is corrupted.')

    # (0xc00d10b1) Windows Media Player cannot add the playlist to the library because the playlist does not contain any items.
    NS_E_WMPCORE_PLAYLIST_IMPORT_FAILED_NO_ITEMS = HResultCode.new('NS_E_WMPCORE_PLAYLIST_IMPORT_FAILED_NO_ITEMS', 0xc00d10b1, 'Windows Media Player cannot add the playlist to the library because the playlist does not contain any items.')

    # (0xc00d10b2) An error has occurred that could prevent the changing of the video contrast on this media.
    NS_E_WMPCORE_VIDEO_TRANSFORM_FILTER_INSERTION = HResultCode.new('NS_E_WMPCORE_VIDEO_TRANSFORM_FILTER_INSERTION', 0xc00d10b2, 'An error has occurred that could prevent the changing of the video contrast on this media.')

    # (0xc00d10b3) Windows Media Player cannot play the file. If the file is located on the Internet, connect to the Internet. If the file is located on a removable storage card, insert the storage card.
    NS_E_WMPCORE_MEDIA_UNAVAILABLE = HResultCode.new('NS_E_WMPCORE_MEDIA_UNAVAILABLE', 0xc00d10b3, 'Windows Media Player cannot play the file. If the file is located on the Internet, connect to the Internet. If the file is located on a removable storage card, insert the storage card.')

    # (0xc00d10b4) The playlist contains an ENTRYREF for which no href was parsed. Check the syntax of playlist file.
    NS_E_WMPCORE_WMX_ENTRYREF_NO_REF = HResultCode.new('NS_E_WMPCORE_WMX_ENTRYREF_NO_REF', 0xc00d10b4, 'The playlist contains an ENTRYREF for which no href was parsed. Check the syntax of playlist file.')

    # (0xc00d10b5) Windows Media Player cannot play any items in the playlist. To find information about the problem, click the Now Playing tab, and then click the icon next to each file in the List pane.
    NS_E_WMPCORE_NO_PLAYABLE_MEDIA_IN_PLAYLIST = HResultCode.new('NS_E_WMPCORE_NO_PLAYABLE_MEDIA_IN_PLAYLIST', 0xc00d10b5, 'Windows Media Player cannot play any items in the playlist. To find information about the problem, click the Now Playing tab, and then click the icon next to each file in the List pane.')

    # (0xc00d10b6) Windows Media Player cannot play some or all of the items in the playlist because the playlist is nested.
    NS_E_WMPCORE_PLAYLIST_EMPTY_NESTED_PLAYLIST_SKIPPED_ITEMS = HResultCode.new('NS_E_WMPCORE_PLAYLIST_EMPTY_NESTED_PLAYLIST_SKIPPED_ITEMS', 0xc00d10b6, 'Windows Media Player cannot play some or all of the items in the playlist because the playlist is nested.')

    # (0xc00d10b7) Windows Media Player cannot play the file at this time. Try again later.
    NS_E_WMPCORE_BUSY = HResultCode.new('NS_E_WMPCORE_BUSY', 0xc00d10b7, 'Windows Media Player cannot play the file at this time. Try again later.')

    # (0xc00d10b8) There is no child playlist available for this media item at this time.
    NS_E_WMPCORE_MEDIA_CHILD_PLAYLIST_UNAVAILABLE = HResultCode.new('NS_E_WMPCORE_MEDIA_CHILD_PLAYLIST_UNAVAILABLE', 0xc00d10b8, 'There is no child playlist available for this media item at this time.')

    # (0xc00d10b9) There is no child playlist for this media item.
    NS_E_WMPCORE_MEDIA_NO_CHILD_PLAYLIST = HResultCode.new('NS_E_WMPCORE_MEDIA_NO_CHILD_PLAYLIST', 0xc00d10b9, 'There is no child playlist for this media item.')

    # (0xc00d10ba) Windows Media Player cannot find the file. The link from the item in the library to its associated digital media file might be broken. To fix the problem, try repairing the link or removing the item from the library.
    NS_E_WMPCORE_FILE_NOT_FOUND = HResultCode.new('NS_E_WMPCORE_FILE_NOT_FOUND', 0xc00d10ba, 'Windows Media Player cannot find the file. The link from the item in the library to its associated digital media file might be broken. To fix the problem, try repairing the link or removing the item from the library.')

    # (0xc00d10bb) The temporary file was not found.
    NS_E_WMPCORE_TEMP_FILE_NOT_FOUND = HResultCode.new('NS_E_WMPCORE_TEMP_FILE_NOT_FOUND', 0xc00d10bb, 'The temporary file was not found.')

    # (0xc00d10bc) Windows Media Player cannot sync the file because the device needs to be updated.
    NS_E_WMDM_REVOKED = HResultCode.new('NS_E_WMDM_REVOKED', 0xc00d10bc, 'Windows Media Player cannot sync the file because the device needs to be updated.')

    # (0xc00d10bd) Windows Media Player cannot play the video because there is a problem with your video card.
    NS_E_DDRAW_GENERIC = HResultCode.new('NS_E_DDRAW_GENERIC', 0xc00d10bd, 'Windows Media Player cannot play the video because there is a problem with your video card.')

    # (0xc00d10be) Windows Media Player failed to change the screen mode for full-screen video playback.
    NS_E_DISPLAY_MODE_CHANGE_FAILED = HResultCode.new('NS_E_DISPLAY_MODE_CHANGE_FAILED', 0xc00d10be, 'Windows Media Player failed to change the screen mode for full-screen video playback.')

    # (0xc00d10bf) Windows Media Player cannot play one or more files. For additional information, right-click an item that cannot be played, and then click Error Details.
    NS_E_PLAYLIST_CONTAINS_ERRORS = HResultCode.new('NS_E_PLAYLIST_CONTAINS_ERRORS', 0xc00d10bf, 'Windows Media Player cannot play one or more files. For additional information, right-click an item that cannot be played, and then click Error Details.')

    # (0xc00d10c0) Cannot change the proxy name if the proxy setting is not set to custom.
    NS_E_CHANGING_PROXY_NAME = HResultCode.new('NS_E_CHANGING_PROXY_NAME', 0xc00d10c0, 'Cannot change the proxy name if the proxy setting is not set to custom.')

    # (0xc00d10c1) Cannot change the proxy port if the proxy setting is not set to custom.
    NS_E_CHANGING_PROXY_PORT = HResultCode.new('NS_E_CHANGING_PROXY_PORT', 0xc00d10c1, 'Cannot change the proxy port if the proxy setting is not set to custom.')

    # (0xc00d10c2) Cannot change the proxy exception list if the proxy setting is not set to custom.
    NS_E_CHANGING_PROXY_EXCEPTIONLIST = HResultCode.new('NS_E_CHANGING_PROXY_EXCEPTIONLIST', 0xc00d10c2, 'Cannot change the proxy exception list if the proxy setting is not set to custom.')

    # (0xc00d10c3) Cannot change the proxy bypass flag if the proxy setting is not set to custom.
    NS_E_CHANGING_PROXYBYPASS = HResultCode.new('NS_E_CHANGING_PROXYBYPASS', 0xc00d10c3, 'Cannot change the proxy bypass flag if the proxy setting is not set to custom.')

    # (0xc00d10c4) Cannot find the specified protocol.
    NS_E_CHANGING_PROXY_PROTOCOL_NOT_FOUND = HResultCode.new('NS_E_CHANGING_PROXY_PROTOCOL_NOT_FOUND', 0xc00d10c4, 'Cannot find the specified protocol.')

    # (0xc00d10c5) Cannot change the language settings. Either the graph has no audio or the audio only supports one language.
    NS_E_GRAPH_NOAUDIOLANGUAGE = HResultCode.new('NS_E_GRAPH_NOAUDIOLANGUAGE', 0xc00d10c5, 'Cannot change the language settings. Either the graph has no audio or the audio only supports one language.')

    # (0xc00d10c6) The graph has no audio language selected.
    NS_E_GRAPH_NOAUDIOLANGUAGESELECTED = HResultCode.new('NS_E_GRAPH_NOAUDIOLANGUAGESELECTED', 0xc00d10c6, 'The graph has no audio language selected.')

    # (0xc00d10c7) This is not a media CD.
    NS_E_CORECD_NOTAMEDIACD = HResultCode.new('NS_E_CORECD_NOTAMEDIACD', 0xc00d10c7, 'This is not a media CD.')

    # (0xc00d10c8) Windows Media Player cannot play the file because the URL is too long.
    NS_E_WMPCORE_MEDIA_URL_TOO_LONG = HResultCode.new('NS_E_WMPCORE_MEDIA_URL_TOO_LONG', 0xc00d10c8, 'Windows Media Player cannot play the file because the URL is too long.')

    # (0xc00d10c9) To play the selected item, you must install the Macromedia Flash Player. To download the Macromedia Flash Player, go to the Adobe website.
    NS_E_WMPFLASH_CANT_FIND_COM_SERVER = HResultCode.new('NS_E_WMPFLASH_CANT_FIND_COM_SERVER', 0xc00d10c9, 'To play the selected item, you must install the Macromedia Flash Player. To download the Macromedia Flash Player, go to the Adobe website.')

    # (0xc00d10ca) To play the selected item, you must install a later version of the Macromedia Flash Player. To download the Macromedia Flash Player, go to the Adobe website.
    NS_E_WMPFLASH_INCOMPATIBLEVERSION = HResultCode.new('NS_E_WMPFLASH_INCOMPATIBLEVERSION', 0xc00d10ca, 'To play the selected item, you must install a later version of the Macromedia Flash Player. To download the Macromedia Flash Player, go to the Adobe website.')

    # (0xc00d10cb) Windows Media Player cannot play the file because your Internet security settings prohibit the use of ActiveX controls.
    NS_E_WMPOCXGRAPH_IE_DISALLOWS_ACTIVEX_CONTROLS = HResultCode.new('NS_E_WMPOCXGRAPH_IE_DISALLOWS_ACTIVEX_CONTROLS', 0xc00d10cb, 'Windows Media Player cannot play the file because your Internet security settings prohibit the use of ActiveX controls.')

    # (0xc00d10cc) The use of this method requires an existing reference to the Player object.
    NS_E_NEED_CORE_REFERENCE = HResultCode.new('NS_E_NEED_CORE_REFERENCE', 0xc00d10cc, 'The use of this method requires an existing reference to the Player object.')

    # (0xc00d10cd) Windows Media Player cannot play the CD. The disc might be dirty or damaged.
    NS_E_MEDIACD_READ_ERROR = HResultCode.new('NS_E_MEDIACD_READ_ERROR', 0xc00d10cd, 'Windows Media Player cannot play the CD. The disc might be dirty or damaged.')

    # (0xc00d10ce) Windows Media Player cannot play the file because your Internet security settings prohibit the use of ActiveX controls.
    NS_E_IE_DISALLOWS_ACTIVEX_CONTROLS = HResultCode.new('NS_E_IE_DISALLOWS_ACTIVEX_CONTROLS', 0xc00d10ce, 'Windows Media Player cannot play the file because your Internet security settings prohibit the use of ActiveX controls.')

    # (0xc00d10cf) Flash playback has been turned off in Windows Media Player.
    NS_E_FLASH_PLAYBACK_NOT_ALLOWED = HResultCode.new('NS_E_FLASH_PLAYBACK_NOT_ALLOWED', 0xc00d10cf, 'Flash playback has been turned off in Windows Media Player.')

    # (0xc00d10d0) Windows Media Player cannot rip the CD because a valid rip location cannot be created.
    NS_E_UNABLE_TO_CREATE_RIP_LOCATION = HResultCode.new('NS_E_UNABLE_TO_CREATE_RIP_LOCATION', 0xc00d10d0, 'Windows Media Player cannot rip the CD because a valid rip location cannot be created.')

    # (0xc00d10d1) Windows Media Player cannot play the file because a required codec is not installed on your computer.
    NS_E_WMPCORE_SOME_CODECS_MISSING = HResultCode.new('NS_E_WMPCORE_SOME_CODECS_MISSING', 0xc00d10d1, 'Windows Media Player cannot play the file because a required codec is not installed on your computer.')

    # (0xc00d10d2) Windows Media Player cannot rip one or more tracks from the CD.
    NS_E_WMP_RIP_FAILED = HResultCode.new('NS_E_WMP_RIP_FAILED', 0xc00d10d2, 'Windows Media Player cannot rip one or more tracks from the CD.')

    # (0xc00d10d3) Windows Media Player encountered a problem while ripping the track from the CD. For additional assistance, click Web Help.
    NS_E_WMP_FAILED_TO_RIP_TRACK = HResultCode.new('NS_E_WMP_FAILED_TO_RIP_TRACK', 0xc00d10d3, 'Windows Media Player encountered a problem while ripping the track from the CD. For additional assistance, click Web Help.')

    # (0xc00d10d4) Windows Media Player encountered a problem while erasing the disc. For additional assistance, click Web Help.
    NS_E_WMP_ERASE_FAILED = HResultCode.new('NS_E_WMP_ERASE_FAILED', 0xc00d10d4, 'Windows Media Player encountered a problem while erasing the disc. For additional assistance, click Web Help.')

    # (0xc00d10d5) Windows Media Player encountered a problem while formatting the device. For additional assistance, click Web Help.
    NS_E_WMP_FORMAT_FAILED = HResultCode.new('NS_E_WMP_FORMAT_FAILED', 0xc00d10d5, 'Windows Media Player encountered a problem while formatting the device. For additional assistance, click Web Help.')

    # (0xc00d10d6) This file cannot be burned to a CD because it is not located on your computer.
    NS_E_WMP_CANNOT_BURN_NON_LOCAL_FILE = HResultCode.new('NS_E_WMP_CANNOT_BURN_NON_LOCAL_FILE', 0xc00d10d6, 'This file cannot be burned to a CD because it is not located on your computer.')

    # (0xc00d10d7) It is not possible to burn this file type to an audio CD. Windows Media Player can burn the following file types to an audio CD: WMA, MP3, or WAV.
    NS_E_WMP_FILE_TYPE_CANNOT_BURN_TO_AUDIO_CD = HResultCode.new('NS_E_WMP_FILE_TYPE_CANNOT_BURN_TO_AUDIO_CD', 0xc00d10d7, 'It is not possible to burn this file type to an audio CD. Windows Media Player can burn the following file types to an audio CD: WMA, MP3, or WAV.')

    # (0xc00d10d8) This file is too large to fit on a disc.
    NS_E_WMP_FILE_DOES_NOT_FIT_ON_CD = HResultCode.new('NS_E_WMP_FILE_DOES_NOT_FIT_ON_CD', 0xc00d10d8, 'This file is too large to fit on a disc.')

    # (0xc00d10d9) It is not possible to determine if this file can fit on a disc because Windows Media Player cannot detect the length of the file. Playing the file before burning might enable the Player to detect the file length.
    NS_E_WMP_FILE_NO_DURATION = HResultCode.new('NS_E_WMP_FILE_NO_DURATION', 0xc00d10d9, 'It is not possible to determine if this file can fit on a disc because Windows Media Player cannot detect the length of the file. Playing the file before burning might enable the Player to detect the file length.')

    # (0xc00d10da) Windows Media Player encountered a problem while burning the file to the disc. For additional assistance, click Web Help.
    NS_E_PDA_FAILED_TO_BURN = HResultCode.new('NS_E_PDA_FAILED_TO_BURN', 0xc00d10da, 'Windows Media Player encountered a problem while burning the file to the disc. For additional assistance, click Web Help.')

    # (0xc00d10dc) Windows Media Player cannot burn the audio CD because some items in the list that you chose to buy could not be downloaded from the online store.
    NS_E_FAILED_DOWNLOAD_ABORT_BURN = HResultCode.new('NS_E_FAILED_DOWNLOAD_ABORT_BURN', 0xc00d10dc, 'Windows Media Player cannot burn the audio CD because some items in the list that you chose to buy could not be downloaded from the online store.')

    # (0xc00d10dd) Windows Media Player cannot play the file. Try using Windows Update or Device Manager to update the device drivers for your audio and video cards. For information about using Windows Update or Device Manager, see Windows Help.
    NS_E_WMPCORE_DEVICE_DRIVERS_MISSING = HResultCode.new('NS_E_WMPCORE_DEVICE_DRIVERS_MISSING', 0xc00d10dd, 'Windows Media Player cannot play the file. Try using Windows Update or Device Manager to update the device drivers for your audio and video cards. For information about using Windows Update or Device Manager, see Windows Help.')

    # (0xc00d1126) Windows Media Player has detected that you are not connected to the Internet. Connect to the Internet, and then try again.
    NS_E_WMPIM_USEROFFLINE = HResultCode.new('NS_E_WMPIM_USEROFFLINE', 0xc00d1126, 'Windows Media Player has detected that you are not connected to the Internet. Connect to the Internet, and then try again.')

    # (0xc00d1127) The attempt to connect to the Internet was canceled.
    NS_E_WMPIM_USERCANCELED = HResultCode.new('NS_E_WMPIM_USERCANCELED', 0xc00d1127, 'The attempt to connect to the Internet was canceled.')

    # (0xc00d1128) The attempt to connect to the Internet failed.
    NS_E_WMPIM_DIALUPFAILED = HResultCode.new('NS_E_WMPIM_DIALUPFAILED', 0xc00d1128, 'The attempt to connect to the Internet failed.')

    # (0xc00d1129) Windows Media Player has encountered an unknown network error.
    NS_E_WINSOCK_ERROR_STRING = HResultCode.new('NS_E_WINSOCK_ERROR_STRING', 0xc00d1129, 'Windows Media Player has encountered an unknown network error.')

    # (0xc00d1130) No window is currently listening to Backup and Restore events.
    NS_E_WMPBR_NOLISTENER = HResultCode.new('NS_E_WMPBR_NOLISTENER', 0xc00d1130, 'No window is currently listening to Backup and Restore events.')

    # (0xc00d1131) Your media usage rights were not backed up because the backup was canceled.
    NS_E_WMPBR_BACKUPCANCEL = HResultCode.new('NS_E_WMPBR_BACKUPCANCEL', 0xc00d1131, 'Your media usage rights were not backed up because the backup was canceled.')

    # (0xc00d1132) Your media usage rights were not restored because the restoration was canceled.
    NS_E_WMPBR_RESTORECANCEL = HResultCode.new('NS_E_WMPBR_RESTORECANCEL', 0xc00d1132, 'Your media usage rights were not restored because the restoration was canceled.')

    # (0xc00d1133) An error occurred while backing up or restoring your media usage rights. A required web page cannot be displayed.
    NS_E_WMPBR_ERRORWITHURL = HResultCode.new('NS_E_WMPBR_ERRORWITHURL', 0xc00d1133, 'An error occurred while backing up or restoring your media usage rights. A required web page cannot be displayed.')

    # (0xc00d1134) Your media usage rights were not backed up because the backup was canceled.
    NS_E_WMPBR_NAMECOLLISION = HResultCode.new('NS_E_WMPBR_NAMECOLLISION', 0xc00d1134, 'Your media usage rights were not backed up because the backup was canceled.')

    # (0xc00d1137) Windows Media Player cannot restore your media usage rights from the specified location. Choose another location, and then try again.
    NS_E_WMPBR_DRIVE_INVALID = HResultCode.new('NS_E_WMPBR_DRIVE_INVALID', 0xc00d1137, 'Windows Media Player cannot restore your media usage rights from the specified location. Choose another location, and then try again.')

    # (0xc00d1138) Windows Media Player cannot backup or restore your media usage rights.
    NS_E_WMPBR_BACKUPRESTOREFAILED = HResultCode.new('NS_E_WMPBR_BACKUPRESTOREFAILED', 0xc00d1138, 'Windows Media Player cannot backup or restore your media usage rights.')

    # (0xc00d1158) Windows Media Player cannot add the file to the library.
    NS_E_WMP_CONVERT_FILE_FAILED = HResultCode.new('NS_E_WMP_CONVERT_FILE_FAILED', 0xc00d1158, 'Windows Media Player cannot add the file to the library.')

    # (0xc00d1159) Windows Media Player cannot add the file to the library because the content provider prohibits it. For assistance, contact the company that provided the file.
    NS_E_WMP_CONVERT_NO_RIGHTS_ERRORURL = HResultCode.new('NS_E_WMP_CONVERT_NO_RIGHTS_ERRORURL', 0xc00d1159, 'Windows Media Player cannot add the file to the library because the content provider prohibits it. For assistance, contact the company that provided the file.')

    # (0xc00d115a) Windows Media Player cannot add the file to the library because the content provider prohibits it. For assistance, contact the company that provided the file.
    NS_E_WMP_CONVERT_NO_RIGHTS_NOERRORURL = HResultCode.new('NS_E_WMP_CONVERT_NO_RIGHTS_NOERRORURL', 0xc00d115a, 'Windows Media Player cannot add the file to the library because the content provider prohibits it. For assistance, contact the company that provided the file.')

    # (0xc00d115b) Windows Media Player cannot add the file to the library. The file might not be valid.
    NS_E_WMP_CONVERT_FILE_CORRUPT = HResultCode.new('NS_E_WMP_CONVERT_FILE_CORRUPT', 0xc00d115b, 'Windows Media Player cannot add the file to the library. The file might not be valid.')

    # (0xc00d115c) Windows Media Player cannot add the file to the library. The plug-in required to add the file is not installed properly. For assistance, click Web Help to display the website of the company that provided the file.
    NS_E_WMP_CONVERT_PLUGIN_UNAVAILABLE_ERRORURL = HResultCode.new('NS_E_WMP_CONVERT_PLUGIN_UNAVAILABLE_ERRORURL', 0xc00d115c, 'Windows Media Player cannot add the file to the library. The plug-in required to add the file is not installed properly. For assistance, click Web Help to display the website of the company that provided the file.')

    # (0xc00d115d) Windows Media Player cannot add the file to the library. The plug-in required to add the file is not installed properly. For assistance, contact the company that provided the file.
    NS_E_WMP_CONVERT_PLUGIN_UNAVAILABLE_NOERRORURL = HResultCode.new('NS_E_WMP_CONVERT_PLUGIN_UNAVAILABLE_NOERRORURL', 0xc00d115d, 'Windows Media Player cannot add the file to the library. The plug-in required to add the file is not installed properly. For assistance, contact the company that provided the file.')

    # (0xc00d115e) Windows Media Player cannot add the file to the library. The plug-in required to add the file is not installed properly. For assistance, contact the company that provided the file.
    NS_E_WMP_CONVERT_PLUGIN_UNKNOWN_FILE_OWNER = HResultCode.new('NS_E_WMP_CONVERT_PLUGIN_UNKNOWN_FILE_OWNER', 0xc00d115e, 'Windows Media Player cannot add the file to the library. The plug-in required to add the file is not installed properly. For assistance, contact the company that provided the file.')

    # (0xc00d1160) Windows Media Player cannot play this DVD. Try installing an updated driver for your video card or obtaining a newer video card.
    NS_E_DVD_DISC_COPY_PROTECT_OUTPUT_NS = HResultCode.new('NS_E_DVD_DISC_COPY_PROTECT_OUTPUT_NS', 0xc00d1160, 'Windows Media Player cannot play this DVD. Try installing an updated driver for your video card or obtaining a newer video card.')

    # (0xc00d1161) This DVD's resolution exceeds the maximum allowed by your component video outputs. Try reducing your screen resolution to 640 x 480, or turn off analog component outputs and use a VGA connection to your monitor.
    NS_E_DVD_DISC_COPY_PROTECT_OUTPUT_FAILED = HResultCode.new('NS_E_DVD_DISC_COPY_PROTECT_OUTPUT_FAILED', 0xc00d1161, 'This DVD\'s resolution exceeds the maximum allowed by your component video outputs. Try reducing your screen resolution to 640 x 480, or turn off analog component outputs and use a VGA connection to your monitor.')

    # (0xc00d1162) Windows Media Player cannot display subtitles or highlights in DVD menus. Reinstall the DVD decoder or contact the DVD drive manufacturer to obtain an updated decoder.
    NS_E_DVD_NO_SUBPICTURE_STREAM = HResultCode.new('NS_E_DVD_NO_SUBPICTURE_STREAM', 0xc00d1162, 'Windows Media Player cannot display subtitles or highlights in DVD menus. Reinstall the DVD decoder or contact the DVD drive manufacturer to obtain an updated decoder.')

    # (0xc00d1163) Windows Media Player cannot play this DVD because there is a problem with digital copy protection between your DVD drive, decoder, and video card. Try installing an updated driver for your video card.
    NS_E_DVD_COPY_PROTECT = HResultCode.new('NS_E_DVD_COPY_PROTECT', 0xc00d1163, 'Windows Media Player cannot play this DVD because there is a problem with digital copy protection between your DVD drive, decoder, and video card. Try installing an updated driver for your video card.')

    # (0xc00d1164) Windows Media Player cannot play the DVD. The disc was created in a manner that the Player does not support.
    NS_E_DVD_AUTHORING_PROBLEM = HResultCode.new('NS_E_DVD_AUTHORING_PROBLEM', 0xc00d1164, 'Windows Media Player cannot play the DVD. The disc was created in a manner that the Player does not support.')

    # (0xc00d1165) Windows Media Player cannot play the DVD because the disc prohibits playback in your region of the world. You must obtain a disc that is intended for your geographic region.
    NS_E_DVD_INVALID_DISC_REGION = HResultCode.new('NS_E_DVD_INVALID_DISC_REGION', 0xc00d1165, 'Windows Media Player cannot play the DVD because the disc prohibits playback in your region of the world. You must obtain a disc that is intended for your geographic region.')

    # (0xc00d1166) Windows Media Player cannot play the DVD because your video card does not support DVD playback.
    NS_E_DVD_COMPATIBLE_VIDEO_CARD = HResultCode.new('NS_E_DVD_COMPATIBLE_VIDEO_CARD', 0xc00d1166, 'Windows Media Player cannot play the DVD because your video card does not support DVD playback.')

    # (0xc00d1167) Windows Media Player cannot play this DVD because it is not possible to turn on analog copy protection on the output display. Try installing an updated driver for your video card.
    NS_E_DVD_MACROVISION = HResultCode.new('NS_E_DVD_MACROVISION', 0xc00d1167, 'Windows Media Player cannot play this DVD because it is not possible to turn on analog copy protection on the output display. Try installing an updated driver for your video card.')

    # (0xc00d1168) Windows Media Player cannot play the DVD because the region assigned to your DVD drive does not match the region assigned to your DVD decoder.
    NS_E_DVD_SYSTEM_DECODER_REGION = HResultCode.new('NS_E_DVD_SYSTEM_DECODER_REGION', 0xc00d1168, 'Windows Media Player cannot play the DVD because the region assigned to your DVD drive does not match the region assigned to your DVD decoder.')

    # (0xc00d1169) Windows Media Player cannot play the DVD because the disc prohibits playback in your region of the world. You must obtain a disc that is intended for your geographic region.
    NS_E_DVD_DISC_DECODER_REGION = HResultCode.new('NS_E_DVD_DISC_DECODER_REGION', 0xc00d1169, 'Windows Media Player cannot play the DVD because the disc prohibits playback in your region of the world. You must obtain a disc that is intended for your geographic region.')

    # (0xc00d116a) Windows Media Player cannot play DVD video. You might need to adjust your Windows display settings. Open display settings in Control Panel, and then try lowering your screen resolution and color quality settings.
    NS_E_DVD_NO_VIDEO_STREAM = HResultCode.new('NS_E_DVD_NO_VIDEO_STREAM', 0xc00d116a, 'Windows Media Player cannot play DVD video. You might need to adjust your Windows display settings. Open display settings in Control Panel, and then try lowering your screen resolution and color quality settings.')

    # (0xc00d116b) Windows Media Player cannot play DVD audio. Verify that your sound card is set up correctly, and then try again.
    NS_E_DVD_NO_AUDIO_STREAM = HResultCode.new('NS_E_DVD_NO_AUDIO_STREAM', 0xc00d116b, 'Windows Media Player cannot play DVD audio. Verify that your sound card is set up correctly, and then try again.')

    # (0xc00d116c) Windows Media Player cannot play DVD video. Close any open files and quit any other programs, and then try again. If the problem persists, restart your computer.
    NS_E_DVD_GRAPH_BUILDING = HResultCode.new('NS_E_DVD_GRAPH_BUILDING', 0xc00d116c, 'Windows Media Player cannot play DVD video. Close any open files and quit any other programs, and then try again. If the problem persists, restart your computer.')

    # (0xc00d116d) Windows Media Player cannot play the DVD because a compatible DVD decoder is not installed on your computer.
    NS_E_DVD_NO_DECODER = HResultCode.new('NS_E_DVD_NO_DECODER', 0xc00d116d, 'Windows Media Player cannot play the DVD because a compatible DVD decoder is not installed on your computer.')

    # (0xc00d116e) Windows Media Player cannot play the scene because it has a parental rating higher than the rating that you are authorized to view.
    NS_E_DVD_PARENTAL = HResultCode.new('NS_E_DVD_PARENTAL', 0xc00d116e, 'Windows Media Player cannot play the scene because it has a parental rating higher than the rating that you are authorized to view.')

    # (0xc00d116f) Windows Media Player cannot skip to the requested location on the DVD.
    NS_E_DVD_CANNOT_JUMP = HResultCode.new('NS_E_DVD_CANNOT_JUMP', 0xc00d116f, 'Windows Media Player cannot skip to the requested location on the DVD.')

    # (0xc00d1170) Windows Media Player cannot play the DVD because it is currently in use by another program. Quit the other program that is using the DVD, and then try again.
    NS_E_DVD_DEVICE_CONTENTION = HResultCode.new('NS_E_DVD_DEVICE_CONTENTION', 0xc00d1170, 'Windows Media Player cannot play the DVD because it is currently in use by another program. Quit the other program that is using the DVD, and then try again.')

    # (0xc00d1171) Windows Media Player cannot play DVD video. You might need to adjust your Windows display settings. Open display settings in Control Panel, and then try lowering your screen resolution and color quality settings.
    NS_E_DVD_NO_VIDEO_MEMORY = HResultCode.new('NS_E_DVD_NO_VIDEO_MEMORY', 0xc00d1171, 'Windows Media Player cannot play DVD video. You might need to adjust your Windows display settings. Open display settings in Control Panel, and then try lowering your screen resolution and color quality settings.')

    # (0xc00d1172) Windows Media Player cannot rip the DVD because it is copy protected.
    NS_E_DVD_CANNOT_COPY_PROTECTED = HResultCode.new('NS_E_DVD_CANNOT_COPY_PROTECTED', 0xc00d1172, 'Windows Media Player cannot rip the DVD because it is copy protected.')

    # (0xc00d1173) One of more of the required properties has not been set.
    NS_E_DVD_REQUIRED_PROPERTY_NOT_SET = HResultCode.new('NS_E_DVD_REQUIRED_PROPERTY_NOT_SET', 0xc00d1173, 'One of more of the required properties has not been set.')

    # (0xc00d1174) The specified title and/or chapter number does not exist on this DVD.
    NS_E_DVD_INVALID_TITLE_CHAPTER = HResultCode.new('NS_E_DVD_INVALID_TITLE_CHAPTER', 0xc00d1174, 'The specified title and/or chapter number does not exist on this DVD.')

    # (0xc00d1176) Windows Media Player cannot burn the files because the Player cannot find a burner. If the burner is connected properly, try using Windows Update to install the latest device driver.
    NS_E_NO_CD_BURNER = HResultCode.new('NS_E_NO_CD_BURNER', 0xc00d1176, 'Windows Media Player cannot burn the files because the Player cannot find a burner. If the burner is connected properly, try using Windows Update to install the latest device driver.')

    # (0xc00d1177) Windows Media Player does not detect storage media in the selected device. Insert storage media into the device, and then try again.
    NS_E_DEVICE_IS_NOT_READY = HResultCode.new('NS_E_DEVICE_IS_NOT_READY', 0xc00d1177, 'Windows Media Player does not detect storage media in the selected device. Insert storage media into the device, and then try again.')

    # (0xc00d1178) Windows Media Player cannot sync this file. The Player might not support the file type.
    NS_E_PDA_UNSUPPORTED_FORMAT = HResultCode.new('NS_E_PDA_UNSUPPORTED_FORMAT', 0xc00d1178, 'Windows Media Player cannot sync this file. The Player might not support the file type.')

    # (0xc00d1179) Windows Media Player does not detect a portable device. Connect your portable device, and then try again.
    NS_E_NO_PDA = HResultCode.new('NS_E_NO_PDA', 0xc00d1179, 'Windows Media Player does not detect a portable device. Connect your portable device, and then try again.')

    # (0xc00d117a) Windows Media Player encountered an error while communicating with the device. The storage card on the device might be full, the device might be turned off, or the device might not allow playlists or folders to be created on it.
    NS_E_PDA_UNSPECIFIED_ERROR = HResultCode.new('NS_E_PDA_UNSPECIFIED_ERROR', 0xc00d117a, 'Windows Media Player encountered an error while communicating with the device. The storage card on the device might be full, the device might be turned off, or the device might not allow playlists or folders to be created on it.')

    # (0xc00d117b) Windows Media Player encountered an error while burning a CD.
    NS_E_MEMSTORAGE_BAD_DATA = HResultCode.new('NS_E_MEMSTORAGE_BAD_DATA', 0xc00d117b, 'Windows Media Player encountered an error while burning a CD.')

    # (0xc00d117c) Windows Media Player encountered an error while communicating with a portable device or CD drive.
    NS_E_PDA_FAIL_SELECT_DEVICE = HResultCode.new('NS_E_PDA_FAIL_SELECT_DEVICE', 0xc00d117c, 'Windows Media Player encountered an error while communicating with a portable device or CD drive.')

    # (0xc00d117d) Windows Media Player cannot open the WAV file.
    NS_E_PDA_FAIL_READ_WAVE_FILE = HResultCode.new('NS_E_PDA_FAIL_READ_WAVE_FILE', 0xc00d117d, 'Windows Media Player cannot open the WAV file.')

    # (0xc00d117e) Windows Media Player failed to burn all the files to the CD. Select a slower recording speed, and then try again.
    NS_E_IMAPI_LOSSOFSTREAMING = HResultCode.new('NS_E_IMAPI_LOSSOFSTREAMING', 0xc00d117e, 'Windows Media Player failed to burn all the files to the CD. Select a slower recording speed, and then try again.')

    # (0xc00d117f) There is not enough storage space on the portable device to complete this operation. Delete some unneeded files on the portable device, and then try again.
    NS_E_PDA_DEVICE_FULL = HResultCode.new('NS_E_PDA_DEVICE_FULL', 0xc00d117f, 'There is not enough storage space on the portable device to complete this operation. Delete some unneeded files on the portable device, and then try again.')

    # (0xc00d1180) Windows Media Player cannot burn the files. Verify that your burner is connected properly, and then try again. If the problem persists, reinstall the Player.
    NS_E_FAIL_LAUNCH_ROXIO_PLUGIN = HResultCode.new('NS_E_FAIL_LAUNCH_ROXIO_PLUGIN', 0xc00d1180, 'Windows Media Player cannot burn the files. Verify that your burner is connected properly, and then try again. If the problem persists, reinstall the Player.')

    # (0xc00d1181) Windows Media Player did not sync some files to the device because there is not enough storage space on the device.
    NS_E_PDA_DEVICE_FULL_IN_SESSION = HResultCode.new('NS_E_PDA_DEVICE_FULL_IN_SESSION', 0xc00d1181, 'Windows Media Player did not sync some files to the device because there is not enough storage space on the device.')

    # (0xc00d1182) The disc in the burner is not valid. Insert a blank disc into the burner, and then try again.
    NS_E_IMAPI_MEDIUM_INVALIDTYPE = HResultCode.new('NS_E_IMAPI_MEDIUM_INVALIDTYPE', 0xc00d1182, 'The disc in the burner is not valid. Insert a blank disc into the burner, and then try again.')

    # (0xc00d1183) Windows Media Player cannot perform the requested action because the device does not support sync.
    NS_E_PDA_MANUALDEVICE = HResultCode.new('NS_E_PDA_MANUALDEVICE', 0xc00d1183, 'Windows Media Player cannot perform the requested action because the device does not support sync.')

    # (0xc00d1184) To perform the requested action, you must first set up sync with the device.
    NS_E_PDA_PARTNERSHIPNOTEXIST = HResultCode.new('NS_E_PDA_PARTNERSHIPNOTEXIST', 0xc00d1184, 'To perform the requested action, you must first set up sync with the device.')

    # (0xc00d1185) You have already created sync partnerships with 16 devices. To create a new sync partnership, you must first end an existing partnership.
    NS_E_PDA_CANNOT_CREATE_ADDITIONAL_SYNC_RELATIONSHIP = HResultCode.new('NS_E_PDA_CANNOT_CREATE_ADDITIONAL_SYNC_RELATIONSHIP', 0xc00d1185, 'You have already created sync partnerships with 16 devices. To create a new sync partnership, you must first end an existing partnership.')

    # (0xc00d1186) Windows Media Player cannot sync the file because protected files cannot be converted to the required quality level or file format.
    NS_E_PDA_NO_TRANSCODE_OF_DRM = HResultCode.new('NS_E_PDA_NO_TRANSCODE_OF_DRM', 0xc00d1186, 'Windows Media Player cannot sync the file because protected files cannot be converted to the required quality level or file format.')

    # (0xc00d1187) The folder that stores converted files is full. Either empty the folder or increase its size, and then try again.
    NS_E_PDA_TRANSCODECACHEFULL = HResultCode.new('NS_E_PDA_TRANSCODECACHEFULL', 0xc00d1187, 'The folder that stores converted files is full. Either empty the folder or increase its size, and then try again.')

    # (0xc00d1188) There are too many files with the same name in the folder on the device. Change the file name or sync to a different folder.
    NS_E_PDA_TOO_MANY_FILE_COLLISIONS = HResultCode.new('NS_E_PDA_TOO_MANY_FILE_COLLISIONS', 0xc00d1188, 'There are too many files with the same name in the folder on the device. Change the file name or sync to a different folder.')

    # (0xc00d1189) Windows Media Player cannot convert the file to the format required by the device.
    NS_E_PDA_CANNOT_TRANSCODE = HResultCode.new('NS_E_PDA_CANNOT_TRANSCODE', 0xc00d1189, 'Windows Media Player cannot convert the file to the format required by the device.')

    # (0xc00d118a) You have reached the maximum number of files your device allows in a folder. If your device supports playback from subfolders, try creating subfolders on the device and storing some files in them.
    NS_E_PDA_TOO_MANY_FILES_IN_DIRECTORY = HResultCode.new('NS_E_PDA_TOO_MANY_FILES_IN_DIRECTORY', 0xc00d118a, 'You have reached the maximum number of files your device allows in a folder. If your device supports playback from subfolders, try creating subfolders on the device and storing some files in them.')

    # (0xc00d118b) Windows Media Player is already trying to start the Device Setup Wizard.
    NS_E_PROCESSINGSHOWSYNCWIZARD = HResultCode.new('NS_E_PROCESSINGSHOWSYNCWIZARD', 0xc00d118b, 'Windows Media Player is already trying to start the Device Setup Wizard.')

    # (0xc00d118c) Windows Media Player cannot convert this file format. If an updated version of the codec used to compress this file is available, install it and then try to sync the file again.
    NS_E_PDA_TRANSCODE_NOT_PERMITTED = HResultCode.new('NS_E_PDA_TRANSCODE_NOT_PERMITTED', 0xc00d118c, 'Windows Media Player cannot convert this file format. If an updated version of the codec used to compress this file is available, install it and then try to sync the file again.')

    # (0xc00d118d) Windows Media Player is busy setting up devices. Try again later.
    NS_E_PDA_INITIALIZINGDEVICES = HResultCode.new('NS_E_PDA_INITIALIZINGDEVICES', 0xc00d118d, 'Windows Media Player is busy setting up devices. Try again later.')

    # (0xc00d118e) Your device is using an outdated driver that is no longer supported by Windows Media Player. For additional assistance, click Web Help.
    NS_E_PDA_OBSOLETE_SP = HResultCode.new('NS_E_PDA_OBSOLETE_SP', 0xc00d118e, 'Your device is using an outdated driver that is no longer supported by Windows Media Player. For additional assistance, click Web Help.')

    # (0xc00d118f) Windows Media Player cannot sync the file because a file with the same name already exists on the device. Change the file name or try to sync the file to a different folder.
    NS_E_PDA_TITLE_COLLISION = HResultCode.new('NS_E_PDA_TITLE_COLLISION', 0xc00d118f, 'Windows Media Player cannot sync the file because a file with the same name already exists on the device. Change the file name or try to sync the file to a different folder.')

    # (0xc00d1190) Automatic and manual sync have been turned off temporarily. To sync to a device, restart Windows Media Player.
    NS_E_PDA_DEVICESUPPORTDISABLED = HResultCode.new('NS_E_PDA_DEVICESUPPORTDISABLED', 0xc00d1190, 'Automatic and manual sync have been turned off temporarily. To sync to a device, restart Windows Media Player.')

    # (0xc00d1191) This device is not available. Connect the device to the computer, and then try again.
    NS_E_PDA_NO_LONGER_AVAILABLE = HResultCode.new('NS_E_PDA_NO_LONGER_AVAILABLE', 0xc00d1191, 'This device is not available. Connect the device to the computer, and then try again.')

    # (0xc00d1192) Windows Media Player cannot sync the file because an error occurred while converting the file to another quality level or format. If the problem persists, remove the file from the list of files to sync.
    NS_E_PDA_ENCODER_NOT_RESPONDING = HResultCode.new('NS_E_PDA_ENCODER_NOT_RESPONDING', 0xc00d1192, 'Windows Media Player cannot sync the file because an error occurred while converting the file to another quality level or format. If the problem persists, remove the file from the list of files to sync.')

    # (0xc00d1193) Windows Media Player cannot sync the file to your device. The file might be stored in a location that is not supported. Copy the file from its current location to your hard disk, add it to your library, and then try to sync the file again.
    NS_E_PDA_CANNOT_SYNC_FROM_LOCATION = HResultCode.new('NS_E_PDA_CANNOT_SYNC_FROM_LOCATION', 0xc00d1193, 'Windows Media Player cannot sync the file to your device. The file might be stored in a location that is not supported. Copy the file from its current location to your hard disk, add it to your library, and then try to sync the file again.')

    # (0xc00d1194) Windows Media Player cannot open the specified URL. Verify that the Player is configured to use all available protocols, and then try again.
    NS_E_WMP_PROTOCOL_PROBLEM = HResultCode.new('NS_E_WMP_PROTOCOL_PROBLEM', 0xc00d1194, 'Windows Media Player cannot open the specified URL. Verify that the Player is configured to use all available protocols, and then try again.')

    # (0xc00d1195) Windows Media Player cannot perform the requested action because there is not enough storage space on your computer. Delete some unneeded files on your hard disk, and then try again.
    NS_E_WMP_NO_DISK_SPACE = HResultCode.new('NS_E_WMP_NO_DISK_SPACE', 0xc00d1195, 'Windows Media Player cannot perform the requested action because there is not enough storage space on your computer. Delete some unneeded files on your hard disk, and then try again.')

    # (0xc00d1196) The server denied access to the file. Verify that you are using the correct user name and password.
    NS_E_WMP_LOGON_FAILURE = HResultCode.new('NS_E_WMP_LOGON_FAILURE', 0xc00d1196, 'The server denied access to the file. Verify that you are using the correct user name and password.')

    # (0xc00d1197) Windows Media Player cannot find the file. If you are trying to play, burn, or sync an item that is in your library, the item might point to a file that has been moved, renamed, or deleted.
    NS_E_WMP_CANNOT_FIND_FILE = HResultCode.new('NS_E_WMP_CANNOT_FIND_FILE', 0xc00d1197, 'Windows Media Player cannot find the file. If you are trying to play, burn, or sync an item that is in your library, the item might point to a file that has been moved, renamed, or deleted.')

    # (0xc00d1198) Windows Media Player cannot connect to the server. The server name might not be correct, the server might not be available, or your proxy settings might not be correct.
    NS_E_WMP_SERVER_INACCESSIBLE = HResultCode.new('NS_E_WMP_SERVER_INACCESSIBLE', 0xc00d1198, 'Windows Media Player cannot connect to the server. The server name might not be correct, the server might not be available, or your proxy settings might not be correct.')

    # (0xc00d1199) Windows Media Player cannot play the file. The Player might not support the file type or might not support the codec that was used to compress the file.
    NS_E_WMP_UNSUPPORTED_FORMAT = HResultCode.new('NS_E_WMP_UNSUPPORTED_FORMAT', 0xc00d1199, 'Windows Media Player cannot play the file. The Player might not support the file type or might not support the codec that was used to compress the file.')

    # (0xc00d119a) Windows Media Player cannot play the file. The Player might not support the file type or a required codec might not be installed on your computer.
    NS_E_WMP_DSHOW_UNSUPPORTED_FORMAT = HResultCode.new('NS_E_WMP_DSHOW_UNSUPPORTED_FORMAT', 0xc00d119a, 'Windows Media Player cannot play the file. The Player might not support the file type or a required codec might not be installed on your computer.')

    # (0xc00d119b) Windows Media Player cannot create the playlist because the name already exists. Type a different playlist name.
    NS_E_WMP_PLAYLIST_EXISTS = HResultCode.new('NS_E_WMP_PLAYLIST_EXISTS', 0xc00d119b, 'Windows Media Player cannot create the playlist because the name already exists. Type a different playlist name.')

    # (0xc00d119c) Windows Media Player cannot delete the playlist because it contains items that are not digital media files. Any digital media files in the playlist were deleted.
    NS_E_WMP_NONMEDIA_FILES = HResultCode.new('NS_E_WMP_NONMEDIA_FILES', 0xc00d119c, 'Windows Media Player cannot delete the playlist because it contains items that are not digital media files. Any digital media files in the playlist were deleted.')

    # (0xc00d119d) The playlist cannot be opened because it is stored in a shared folder on another computer. If possible, move the playlist to the playlists folder on your computer.
    NS_E_WMP_INVALID_ASX = HResultCode.new('NS_E_WMP_INVALID_ASX', 0xc00d119d, 'The playlist cannot be opened because it is stored in a shared folder on another computer. If possible, move the playlist to the playlists folder on your computer.')

    # (0xc00d119e) Windows Media Player is already in use. Stop playing any items, close all Player dialog boxes, and then try again.
    NS_E_WMP_ALREADY_IN_USE = HResultCode.new('NS_E_WMP_ALREADY_IN_USE', 0xc00d119e, 'Windows Media Player is already in use. Stop playing any items, close all Player dialog boxes, and then try again.')

    # (0xc00d119f) Windows Media Player encountered an error while burning. Verify that the burner is connected properly and that the disc is clean and not damaged.
    NS_E_WMP_IMAPI_FAILURE = HResultCode.new('NS_E_WMP_IMAPI_FAILURE', 0xc00d119f, 'Windows Media Player encountered an error while burning. Verify that the burner is connected properly and that the disc is clean and not damaged.')

    # (0xc00d11a0) Windows Media Player has encountered an unknown error with your portable device. Reconnect your portable device, and then try again.
    NS_E_WMP_WMDM_FAILURE = HResultCode.new('NS_E_WMP_WMDM_FAILURE', 0xc00d11a0, 'Windows Media Player has encountered an unknown error with your portable device. Reconnect your portable device, and then try again.')

    # (0xc00d11a1) A codec is required to play this file. To determine if this codec is available to download from the web, click Web Help.
    NS_E_WMP_CODEC_NEEDED_WITH_4CC = HResultCode.new('NS_E_WMP_CODEC_NEEDED_WITH_4CC', 0xc00d11a1, 'A codec is required to play this file. To determine if this codec is available to download from the web, click Web Help.')

    # (0xc00d11a2) An audio codec is needed to play this file. To determine if this codec is available to download from the web, click Web Help.
    NS_E_WMP_CODEC_NEEDED_WITH_FORMATTAG = HResultCode.new('NS_E_WMP_CODEC_NEEDED_WITH_FORMATTAG', 0xc00d11a2, 'An audio codec is needed to play this file. To determine if this codec is available to download from the web, click Web Help.')

    # (0xc00d11a3) To play the file, you must install the latest Windows service pack. To install the service pack from the Windows Update website, click Web Help.
    NS_E_WMP_MSSAP_NOT_AVAILABLE = HResultCode.new('NS_E_WMP_MSSAP_NOT_AVAILABLE', 0xc00d11a3, 'To play the file, you must install the latest Windows service pack. To install the service pack from the Windows Update website, click Web Help.')

    # (0xc00d11a4) Windows Media Player no longer detects a portable device. Reconnect your portable device, and then try again.
    NS_E_WMP_WMDM_INTERFACEDEAD = HResultCode.new('NS_E_WMP_WMDM_INTERFACEDEAD', 0xc00d11a4, 'Windows Media Player no longer detects a portable device. Reconnect your portable device, and then try again.')

    # (0xc00d11a5) Windows Media Player cannot sync the file because the portable device does not support protected files.
    NS_E_WMP_WMDM_NOTCERTIFIED = HResultCode.new('NS_E_WMP_WMDM_NOTCERTIFIED', 0xc00d11a5, 'Windows Media Player cannot sync the file because the portable device does not support protected files.')

    # (0xc00d11a6) This file does not have sync rights. If you obtained this file from an online store, go to the online store to get sync rights.
    NS_E_WMP_WMDM_LICENSE_NOTEXIST = HResultCode.new('NS_E_WMP_WMDM_LICENSE_NOTEXIST', 0xc00d11a6, 'This file does not have sync rights. If you obtained this file from an online store, go to the online store to get sync rights.')

    # (0xc00d11a7) Windows Media Player cannot sync the file because the sync rights have expired. Go to the content provider's online store to get new sync rights.
    NS_E_WMP_WMDM_LICENSE_EXPIRED = HResultCode.new('NS_E_WMP_WMDM_LICENSE_EXPIRED', 0xc00d11a7, 'Windows Media Player cannot sync the file because the sync rights have expired. Go to the content provider\'s online store to get new sync rights.')

    # (0xc00d11a8) The portable device is already in use. Wait until the current task finishes or quit other programs that might be using the portable device, and then try again.
    NS_E_WMP_WMDM_BUSY = HResultCode.new('NS_E_WMP_WMDM_BUSY', 0xc00d11a8, 'The portable device is already in use. Wait until the current task finishes or quit other programs that might be using the portable device, and then try again.')

    # (0xc00d11a9) Windows Media Player cannot sync the file because the content provider or device prohibits it. You might be able to resolve this problem by going to the content provider's online store to get sync rights.
    NS_E_WMP_WMDM_NORIGHTS = HResultCode.new('NS_E_WMP_WMDM_NORIGHTS', 0xc00d11a9, 'Windows Media Player cannot sync the file because the content provider or device prohibits it. You might be able to resolve this problem by going to the content provider\'s online store to get sync rights.')

    # (0xc00d11aa) The content provider has not granted you the right to sync this file. Go to the content provider's online store to get sync rights.
    NS_E_WMP_WMDM_INCORRECT_RIGHTS = HResultCode.new('NS_E_WMP_WMDM_INCORRECT_RIGHTS', 0xc00d11aa, 'The content provider has not granted you the right to sync this file. Go to the content provider\'s online store to get sync rights.')

    # (0xc00d11ab) Windows Media Player cannot burn the files to the CD. Verify that the disc is clean and not damaged. If necessary, select a slower recording speed or try a different brand of blank discs.
    NS_E_WMP_IMAPI_GENERIC = HResultCode.new('NS_E_WMP_IMAPI_GENERIC', 0xc00d11ab, 'Windows Media Player cannot burn the files to the CD. Verify that the disc is clean and not damaged. If necessary, select a slower recording speed or try a different brand of blank discs.')

    # (0xc00d11ad) Windows Media Player cannot burn the files. Verify that the burner is connected properly, and then try again.
    NS_E_WMP_IMAPI_DEVICE_NOTPRESENT = HResultCode.new('NS_E_WMP_IMAPI_DEVICE_NOTPRESENT', 0xc00d11ad, 'Windows Media Player cannot burn the files. Verify that the burner is connected properly, and then try again.')

    # (0xc00d11ae) Windows Media Player cannot burn the files. Verify that the burner is connected properly and that the disc is clean and not damaged. If the burner is already in use, wait until the current task finishes or quit other programs that might be using the burner.
    NS_E_WMP_IMAPI_DEVICE_BUSY = HResultCode.new('NS_E_WMP_IMAPI_DEVICE_BUSY', 0xc00d11ae, 'Windows Media Player cannot burn the files. Verify that the burner is connected properly and that the disc is clean and not damaged. If the burner is already in use, wait until the current task finishes or quit other programs that might be using the burner.')

    # (0xc00d11af) Windows Media Player cannot burn the files to the CD.
    NS_E_WMP_IMAPI_LOSS_OF_STREAMING = HResultCode.new('NS_E_WMP_IMAPI_LOSS_OF_STREAMING', 0xc00d11af, 'Windows Media Player cannot burn the files to the CD.')

    # (0xc00d11b0) Windows Media Player cannot play the file. The server might not be available or there might be a problem with your network or firewall settings.
    NS_E_WMP_SERVER_UNAVAILABLE = HResultCode.new('NS_E_WMP_SERVER_UNAVAILABLE', 0xc00d11b0, 'Windows Media Player cannot play the file. The server might not be available or there might be a problem with your network or firewall settings.')

    # (0xc00d11b1) Windows Media Player encountered a problem while playing the file. For additional assistance, click Web Help.
    NS_E_WMP_FILE_OPEN_FAILED = HResultCode.new('NS_E_WMP_FILE_OPEN_FAILED', 0xc00d11b1, 'Windows Media Player encountered a problem while playing the file. For additional assistance, click Web Help.')

    # (0xc00d11b2) Windows Media Player must connect to the Internet to verify the file's media usage rights. Connect to the Internet, and then try again.
    NS_E_WMP_VERIFY_ONLINE = HResultCode.new('NS_E_WMP_VERIFY_ONLINE', 0xc00d11b2, 'Windows Media Player must connect to the Internet to verify the file\'s media usage rights. Connect to the Internet, and then try again.')

    # (0xc00d11b3) Windows Media Player cannot play the file because a network error occurred. The server might not be available. Verify that you are connected to the network and that your proxy settings are correct.
    NS_E_WMP_SERVER_NOT_RESPONDING = HResultCode.new('NS_E_WMP_SERVER_NOT_RESPONDING', 0xc00d11b3, 'Windows Media Player cannot play the file because a network error occurred. The server might not be available. Verify that you are connected to the network and that your proxy settings are correct.')

    # (0xc00d11b4) Windows Media Player cannot restore your media usage rights because it could not find any backed up rights on your computer.
    NS_E_WMP_DRM_CORRUPT_BACKUP = HResultCode.new('NS_E_WMP_DRM_CORRUPT_BACKUP', 0xc00d11b4, 'Windows Media Player cannot restore your media usage rights because it could not find any backed up rights on your computer.')

    # (0xc00d11b5) Windows Media Player cannot download media usage rights because the server is not available (for example, the server might be busy or not online).
    NS_E_WMP_DRM_LICENSE_SERVER_UNAVAILABLE = HResultCode.new('NS_E_WMP_DRM_LICENSE_SERVER_UNAVAILABLE', 0xc00d11b5, 'Windows Media Player cannot download media usage rights because the server is not available (for example, the server might be busy or not online).')

    # (0xc00d11b6) Windows Media Player cannot play the file. A network firewall might be preventing the Player from opening the file by using the UDP transport protocol. If you typed a URL in the Open URL dialog box, try using a different transport protocol (for example, "http:").
    NS_E_WMP_NETWORK_FIREWALL = HResultCode.new('NS_E_WMP_NETWORK_FIREWALL', 0xc00d11b6, 'Windows Media Player cannot play the file. A network firewall might be preventing the Player from opening the file by using the UDP transport protocol. If you typed a URL in the Open URL dialog box, try using a different transport protocol (for example, "http:").')

    # (0xc00d11b7) Insert the removable media, and then try again.
    NS_E_WMP_NO_REMOVABLE_MEDIA = HResultCode.new('NS_E_WMP_NO_REMOVABLE_MEDIA', 0xc00d11b7, 'Insert the removable media, and then try again.')

    # (0xc00d11b8) Windows Media Player cannot play the file because the proxy server is not responding. The proxy server might be temporarily unavailable or your Player proxy settings might not be valid.
    NS_E_WMP_PROXY_CONNECT_TIMEOUT = HResultCode.new('NS_E_WMP_PROXY_CONNECT_TIMEOUT', 0xc00d11b8, 'Windows Media Player cannot play the file because the proxy server is not responding. The proxy server might be temporarily unavailable or your Player proxy settings might not be valid.')

    # (0xc00d11b9) To play the file, you might need to install a later version of Windows Media Player. On the Help menu, click Check for Updates, and then follow the instructions. For additional assistance, click Web Help.
    NS_E_WMP_NEED_UPGRADE = HResultCode.new('NS_E_WMP_NEED_UPGRADE', 0xc00d11b9, 'To play the file, you might need to install a later version of Windows Media Player. On the Help menu, click Check for Updates, and then follow the instructions. For additional assistance, click Web Help.')

    # (0xc00d11ba) Windows Media Player cannot play the file because there is a problem with your sound device. There might not be a sound device installed on your computer, it might be in use by another program, or it might not be functioning properly.
    NS_E_WMP_AUDIO_HW_PROBLEM = HResultCode.new('NS_E_WMP_AUDIO_HW_PROBLEM', 0xc00d11ba, 'Windows Media Player cannot play the file because there is a problem with your sound device. There might not be a sound device installed on your computer, it might be in use by another program, or it might not be functioning properly.')

    # (0xc00d11bb) Windows Media Player cannot play the file because the specified protocol is not supported. If you typed a URL in the Open URL dialog box, try using a different transport protocol (for example, "http:" or "rtsp:").
    NS_E_WMP_INVALID_PROTOCOL = HResultCode.new('NS_E_WMP_INVALID_PROTOCOL', 0xc00d11bb, 'Windows Media Player cannot play the file because the specified protocol is not supported. If you typed a URL in the Open URL dialog box, try using a different transport protocol (for example, "http:" or "rtsp:").')

    # (0xc00d11bc) Windows Media Player cannot add the file to the library because the file format is not supported.
    NS_E_WMP_INVALID_LIBRARY_ADD = HResultCode.new('NS_E_WMP_INVALID_LIBRARY_ADD', 0xc00d11bc, 'Windows Media Player cannot add the file to the library because the file format is not supported.')

    # (0xc00d11bd) Windows Media Player cannot play the file because the specified protocol is not supported. If you typed a URL in the Open URL dialog box, try using a different transport protocol (for example, "mms:").
    NS_E_WMP_MMS_NOT_SUPPORTED = HResultCode.new('NS_E_WMP_MMS_NOT_SUPPORTED', 0xc00d11bd, 'Windows Media Player cannot play the file because the specified protocol is not supported. If you typed a URL in the Open URL dialog box, try using a different transport protocol (for example, "mms:").')

    # (0xc00d11be) Windows Media Player cannot play the file because there are no streaming protocols selected. Select one or more protocols, and then try again.
    NS_E_WMP_NO_PROTOCOLS_SELECTED = HResultCode.new('NS_E_WMP_NO_PROTOCOLS_SELECTED', 0xc00d11be, 'Windows Media Player cannot play the file because there are no streaming protocols selected. Select one or more protocols, and then try again.')

    # (0xc00d11bf) Windows Media Player cannot switch to Full Screen. You might need to adjust your Windows display settings. Open display settings in Control Panel, and then try setting Hardware acceleration to Full.
    NS_E_WMP_GOFULLSCREEN_FAILED = HResultCode.new('NS_E_WMP_GOFULLSCREEN_FAILED', 0xc00d11bf, 'Windows Media Player cannot switch to Full Screen. You might need to adjust your Windows display settings. Open display settings in Control Panel, and then try setting Hardware acceleration to Full.')

    # (0xc00d11c0) Windows Media Player cannot play the file because a network error occurred. The server might not be available (for example, the server is busy or not online) or you might not be connected to the network.
    NS_E_WMP_NETWORK_ERROR = HResultCode.new('NS_E_WMP_NETWORK_ERROR', 0xc00d11c0, 'Windows Media Player cannot play the file because a network error occurred. The server might not be available (for example, the server is busy or not online) or you might not be connected to the network.')

    # (0xc00d11c1) Windows Media Player cannot play the file because the server is not responding. Verify that you are connected to the network, and then try again later.
    NS_E_WMP_CONNECT_TIMEOUT = HResultCode.new('NS_E_WMP_CONNECT_TIMEOUT', 0xc00d11c1, 'Windows Media Player cannot play the file because the server is not responding. Verify that you are connected to the network, and then try again later.')

    # (0xc00d11c2) Windows Media Player cannot play the file because the multicast protocol is not enabled. On the Tools menu, click Options, click the Network tab, and then select the Multicast check box. For additional assistance, click Web Help.
    NS_E_WMP_MULTICAST_DISABLED = HResultCode.new('NS_E_WMP_MULTICAST_DISABLED', 0xc00d11c2, 'Windows Media Player cannot play the file because the multicast protocol is not enabled. On the Tools menu, click Options, click the Network tab, and then select the Multicast check box. For additional assistance, click Web Help.')

    # (0xc00d11c3) Windows Media Player cannot play the file because a network problem occurred. Verify that you are connected to the network, and then try again later.
    NS_E_WMP_SERVER_DNS_TIMEOUT = HResultCode.new('NS_E_WMP_SERVER_DNS_TIMEOUT', 0xc00d11c3, 'Windows Media Player cannot play the file because a network problem occurred. Verify that you are connected to the network, and then try again later.')

    # (0xc00d11c4) Windows Media Player cannot play the file because the network proxy server cannot be found. Verify that your proxy settings are correct, and then try again.
    NS_E_WMP_PROXY_NOT_FOUND = HResultCode.new('NS_E_WMP_PROXY_NOT_FOUND', 0xc00d11c4, 'Windows Media Player cannot play the file because the network proxy server cannot be found. Verify that your proxy settings are correct, and then try again.')

    # (0xc00d11c5) Windows Media Player cannot play the file because it is corrupted.
    NS_E_WMP_TAMPERED_CONTENT = HResultCode.new('NS_E_WMP_TAMPERED_CONTENT', 0xc00d11c5, 'Windows Media Player cannot play the file because it is corrupted.')

    # (0xc00d11c6) Your computer is running low on memory. Quit other programs, and then try again.
    NS_E_WMP_OUTOFMEMORY = HResultCode.new('NS_E_WMP_OUTOFMEMORY', 0xc00d11c6, 'Your computer is running low on memory. Quit other programs, and then try again.')

    # (0xc00d11c7) Windows Media Player cannot play, burn, rip, or sync the file because a required audio codec is not installed on your computer.
    NS_E_WMP_AUDIO_CODEC_NOT_INSTALLED = HResultCode.new('NS_E_WMP_AUDIO_CODEC_NOT_INSTALLED', 0xc00d11c7, 'Windows Media Player cannot play, burn, rip, or sync the file because a required audio codec is not installed on your computer.')

    # (0xc00d11c8) Windows Media Player cannot play the file because the required video codec is not installed on your computer.
    NS_E_WMP_VIDEO_CODEC_NOT_INSTALLED = HResultCode.new('NS_E_WMP_VIDEO_CODEC_NOT_INSTALLED', 0xc00d11c8, 'Windows Media Player cannot play the file because the required video codec is not installed on your computer.')

    # (0xc00d11c9) Windows Media Player cannot burn the files. If the burner is busy, wait for the current task to finish. If necessary, verify that the burner is connected properly and that you have installed the latest device driver.
    NS_E_WMP_IMAPI_DEVICE_INVALIDTYPE = HResultCode.new('NS_E_WMP_IMAPI_DEVICE_INVALIDTYPE', 0xc00d11c9, 'Windows Media Player cannot burn the files. If the burner is busy, wait for the current task to finish. If necessary, verify that the burner is connected properly and that you have installed the latest device driver.')

    # (0xc00d11ca) Windows Media Player cannot play the protected file because there is a problem with your sound device. Try installing a new device driver or use a different sound device.
    NS_E_WMP_DRM_DRIVER_AUTH_FAILURE = HResultCode.new('NS_E_WMP_DRM_DRIVER_AUTH_FAILURE', 0xc00d11ca, 'Windows Media Player cannot play the protected file because there is a problem with your sound device. Try installing a new device driver or use a different sound device.')

    # (0xc00d11cb) Windows Media Player encountered a network error. Restart the Player.
    NS_E_WMP_NETWORK_RESOURCE_FAILURE = HResultCode.new('NS_E_WMP_NETWORK_RESOURCE_FAILURE', 0xc00d11cb, 'Windows Media Player encountered a network error. Restart the Player.')

    # (0xc00d11cc) Windows Media Player is not installed properly. Reinstall the Player.
    NS_E_WMP_UPGRADE_APPLICATION = HResultCode.new('NS_E_WMP_UPGRADE_APPLICATION', 0xc00d11cc, 'Windows Media Player is not installed properly. Reinstall the Player.')

    # (0xc00d11cd) Windows Media Player encountered an unknown error. For additional assistance, click Web Help.
    NS_E_WMP_UNKNOWN_ERROR = HResultCode.new('NS_E_WMP_UNKNOWN_ERROR', 0xc00d11cd, 'Windows Media Player encountered an unknown error. For additional assistance, click Web Help.')

    # (0xc00d11ce) Windows Media Player cannot play the file because the required codec is not valid.
    NS_E_WMP_INVALID_KEY = HResultCode.new('NS_E_WMP_INVALID_KEY', 0xc00d11ce, 'Windows Media Player cannot play the file because the required codec is not valid.')

    # (0xc00d11cf) The CD drive is in use by another user. Wait for the task to complete, and then try again.
    NS_E_WMP_CD_ANOTHER_USER = HResultCode.new('NS_E_WMP_CD_ANOTHER_USER', 0xc00d11cf, 'The CD drive is in use by another user. Wait for the task to complete, and then try again.')

    # (0xc00d11d0) Windows Media Player cannot play, sync, or burn the protected file because a problem occurred with the Windows Media Digital Rights Management (DRM) system. You might need to connect to the Internet to update your DRM components. For additional assistance, click Web Help.
    NS_E_WMP_DRM_NEEDS_AUTHORIZATION = HResultCode.new('NS_E_WMP_DRM_NEEDS_AUTHORIZATION', 0xc00d11d0, 'Windows Media Player cannot play, sync, or burn the protected file because a problem occurred with the Windows Media Digital Rights Management (DRM) system. You might need to connect to the Internet to update your DRM components. For additional assistance, click Web Help.')

    # (0xc00d11d1) Windows Media Player cannot play the file because there might be a problem with your sound or video device. Try installing an updated device driver.
    NS_E_WMP_BAD_DRIVER = HResultCode.new('NS_E_WMP_BAD_DRIVER', 0xc00d11d1, 'Windows Media Player cannot play the file because there might be a problem with your sound or video device. Try installing an updated device driver.')

    # (0xc00d11d2) Windows Media Player cannot access the file. The file might be in use, you might not have access to the computer where the file is stored, or your proxy settings might not be correct.
    NS_E_WMP_ACCESS_DENIED = HResultCode.new('NS_E_WMP_ACCESS_DENIED', 0xc00d11d2, 'Windows Media Player cannot access the file. The file might be in use, you might not have access to the computer where the file is stored, or your proxy settings might not be correct.')

    # (0xc00d11d3) The content provider prohibits this action. Go to the content provider's online store to get new media usage rights.
    NS_E_WMP_LICENSE_RESTRICTS = HResultCode.new('NS_E_WMP_LICENSE_RESTRICTS', 0xc00d11d3, 'The content provider prohibits this action. Go to the content provider\'s online store to get new media usage rights.')

    # (0xc00d11d4) Windows Media Player cannot perform the requested action at this time.
    NS_E_WMP_INVALID_REQUEST = HResultCode.new('NS_E_WMP_INVALID_REQUEST', 0xc00d11d4, 'Windows Media Player cannot perform the requested action at this time.')

    # (0xc00d11d5) Windows Media Player cannot burn the files because there is not enough free disk space to store the temporary files. Delete some unneeded files on your hard disk, and then try again.
    NS_E_WMP_CD_STASH_NO_SPACE = HResultCode.new('NS_E_WMP_CD_STASH_NO_SPACE', 0xc00d11d5, 'Windows Media Player cannot burn the files because there is not enough free disk space to store the temporary files. Delete some unneeded files on your hard disk, and then try again.')

    # (0xc00d11d6) Your media usage rights have become corrupted or are no longer valid. This might happen if you have replaced hardware components in your computer.
    NS_E_WMP_DRM_NEW_HARDWARE = HResultCode.new('NS_E_WMP_DRM_NEW_HARDWARE', 0xc00d11d6, 'Your media usage rights have become corrupted or are no longer valid. This might happen if you have replaced hardware components in your computer.')

    # (0xc00d11d7) The required Windows Media Digital Rights Management (DRM) component cannot be validated. You might be able resolve the problem by reinstalling the Player.
    NS_E_WMP_DRM_INVALID_SIG = HResultCode.new('NS_E_WMP_DRM_INVALID_SIG', 0xc00d11d7, 'The required Windows Media Digital Rights Management (DRM) component cannot be validated. You might be able resolve the problem by reinstalling the Player.')

    # (0xc00d11d8) You have exceeded your restore limit for the day. Try restoring your media usage rights tomorrow.
    NS_E_WMP_DRM_CANNOT_RESTORE = HResultCode.new('NS_E_WMP_DRM_CANNOT_RESTORE', 0xc00d11d8, 'You have exceeded your restore limit for the day. Try restoring your media usage rights tomorrow.')

    # (0xc00d11d9) Some files might not fit on the CD. The required space cannot be calculated accurately because some files might be missing duration information. To ensure the calculation is accurate, play the files that are missing duration information.
    NS_E_WMP_BURN_DISC_OVERFLOW = HResultCode.new('NS_E_WMP_BURN_DISC_OVERFLOW', 0xc00d11d9, 'Some files might not fit on the CD. The required space cannot be calculated accurately because some files might be missing duration information. To ensure the calculation is accurate, play the files that are missing duration information.')

    # (0xc00d11da) Windows Media Player cannot verify the file's media usage rights. If you obtained this file from an online store, go to the online store to get the necessary rights.
    NS_E_WMP_DRM_GENERIC_LICENSE_FAILURE = HResultCode.new('NS_E_WMP_DRM_GENERIC_LICENSE_FAILURE', 0xc00d11da, 'Windows Media Player cannot verify the file\'s media usage rights. If you obtained this file from an online store, go to the online store to get the necessary rights.')

    # (0xc00d11db) It is not possible to sync because this device's internal clock is not set correctly. To set the clock, select the option to set the device clock on the Privacy tab of the Options dialog box, connect to the Internet, and then sync the device again. For additional assistance, click Web Help.
    NS_E_WMP_DRM_NO_SECURE_CLOCK = HResultCode.new('NS_E_WMP_DRM_NO_SECURE_CLOCK', 0xc00d11db, 'It is not possible to sync because this device\'s internal clock is not set correctly. To set the clock, select the option to set the device clock on the Privacy tab of the Options dialog box, connect to the Internet, and then sync the device again. For additional assistance, click Web Help.')

    # (0xc00d11dc) Windows Media Player cannot play, burn, rip, or sync the protected file because you do not have the appropriate rights.
    NS_E_WMP_DRM_NO_RIGHTS = HResultCode.new('NS_E_WMP_DRM_NO_RIGHTS', 0xc00d11dc, 'Windows Media Player cannot play, burn, rip, or sync the protected file because you do not have the appropriate rights.')

    # (0xc00d11dd) Windows Media Player encountered an error during upgrade.
    NS_E_WMP_DRM_INDIV_FAILED = HResultCode.new('NS_E_WMP_DRM_INDIV_FAILED', 0xc00d11dd, 'Windows Media Player encountered an error during upgrade.')

    # (0xc00d11de) Windows Media Player cannot connect to the server because it is not accepting any new connections. This could be because it has reached its maximum connection limit. Please try again later.
    NS_E_WMP_SERVER_NONEWCONNECTIONS = HResultCode.new('NS_E_WMP_SERVER_NONEWCONNECTIONS', 0xc00d11de, 'Windows Media Player cannot connect to the server because it is not accepting any new connections. This could be because it has reached its maximum connection limit. Please try again later.')

    # (0xc00d11df) A number of queued files cannot be played. To find information about the problem, click the Now Playing tab, and then click the icon next to each file in the List pane.
    NS_E_WMP_MULTIPLE_ERROR_IN_PLAYLIST = HResultCode.new('NS_E_WMP_MULTIPLE_ERROR_IN_PLAYLIST', 0xc00d11df, 'A number of queued files cannot be played. To find information about the problem, click the Now Playing tab, and then click the icon next to each file in the List pane.')

    # (0xc00d11e0) Windows Media Player encountered an error while erasing the rewritable CD or DVD. Verify that the CD or DVD burner is connected properly and that the disc is clean and not damaged.
    NS_E_WMP_IMAPI2_ERASE_FAIL = HResultCode.new('NS_E_WMP_IMAPI2_ERASE_FAIL', 0xc00d11e0, 'Windows Media Player encountered an error while erasing the rewritable CD or DVD. Verify that the CD or DVD burner is connected properly and that the disc is clean and not damaged.')

    # (0xc00d11e1) Windows Media Player cannot erase the rewritable CD or DVD. Verify that the CD or DVD burner is connected properly and that the disc is clean and not damaged. If the burner is already in use, wait until the current task finishes or quit other programs that might be using the burner.
    NS_E_WMP_IMAPI2_ERASE_DEVICE_BUSY = HResultCode.new('NS_E_WMP_IMAPI2_ERASE_DEVICE_BUSY', 0xc00d11e1, 'Windows Media Player cannot erase the rewritable CD or DVD. Verify that the CD or DVD burner is connected properly and that the disc is clean and not damaged. If the burner is already in use, wait until the current task finishes or quit other programs that might be using the burner.')

    # (0xc00d11e2) A Windows Media Digital Rights Management (DRM) component encountered a problem. If you are trying to use a file that you obtained from an online store, try going to the online store and getting the appropriate usage rights.
    NS_E_WMP_DRM_COMPONENT_FAILURE = HResultCode.new('NS_E_WMP_DRM_COMPONENT_FAILURE', 0xc00d11e2, 'A Windows Media Digital Rights Management (DRM) component encountered a problem. If you are trying to use a file that you obtained from an online store, try going to the online store and getting the appropriate usage rights.')

    # (0xc00d11e3) It is not possible to obtain device's certificate. Please contact the device manufacturer for a firmware update or for other steps to resolve this problem.
    NS_E_WMP_DRM_NO_DEVICE_CERT = HResultCode.new('NS_E_WMP_DRM_NO_DEVICE_CERT', 0xc00d11e3, 'It is not possible to obtain device\'s certificate. Please contact the device manufacturer for a firmware update or for other steps to resolve this problem.')

    # (0xc00d11e4) Windows Media Player encountered an error when connecting to the server. The security information from the server could not be validated.
    NS_E_WMP_SERVER_SECURITY_ERROR = HResultCode.new('NS_E_WMP_SERVER_SECURITY_ERROR', 0xc00d11e4, 'Windows Media Player encountered an error when connecting to the server. The security information from the server could not be validated.')

    # (0xc00d11e5) An audio device was disconnected or reconfigured. Verify that the audio device is connected, and then try to play the item again.
    NS_E_WMP_AUDIO_DEVICE_LOST = HResultCode.new('NS_E_WMP_AUDIO_DEVICE_LOST', 0xc00d11e5, 'An audio device was disconnected or reconfigured. Verify that the audio device is connected, and then try to play the item again.')

    # (0xc00d11e6) Windows Media Player could not complete burning because the disc is not compatible with your drive. Try inserting a different kind of recordable media or use a disc that supports a write speed that is compatible with your drive.
    NS_E_WMP_IMAPI_MEDIA_INCOMPATIBLE = HResultCode.new('NS_E_WMP_IMAPI_MEDIA_INCOMPATIBLE', 0xc00d11e6, 'Windows Media Player could not complete burning because the disc is not compatible with your drive. Try inserting a different kind of recordable media or use a disc that supports a write speed that is compatible with your drive.')

    # (0xc00d11ee) Windows Media Player cannot save the sync settings because your device is full. Delete some unneeded files on your device and then try again.
    NS_E_SYNCWIZ_DEVICE_FULL = HResultCode.new('NS_E_SYNCWIZ_DEVICE_FULL', 0xc00d11ee, 'Windows Media Player cannot save the sync settings because your device is full. Delete some unneeded files on your device and then try again.')

    # (0xc00d11ef) It is not possible to change sync settings at this time. Try again later.
    NS_E_SYNCWIZ_CANNOT_CHANGE_SETTINGS = HResultCode.new('NS_E_SYNCWIZ_CANNOT_CHANGE_SETTINGS', 0xc00d11ef, 'It is not possible to change sync settings at this time. Try again later.')

    # (0xc00d11f0) Windows Media Player cannot delete these files currently. If the Player is synchronizing, wait until it is complete and then try again.
    NS_E_TRANSCODE_DELETECACHEERROR = HResultCode.new('NS_E_TRANSCODE_DELETECACHEERROR', 0xc00d11f0, 'Windows Media Player cannot delete these files currently. If the Player is synchronizing, wait until it is complete and then try again.')

    # (0xc00d11f8) Windows Media Player could not use digital mode to read the CD. The Player has automatically switched the CD drive to analog mode. To switch back to digital mode, use the Devices tab. For additional assistance, click Web Help.
    NS_E_CD_NO_BUFFERS_READ = HResultCode.new('NS_E_CD_NO_BUFFERS_READ', 0xc00d11f8, 'Windows Media Player could not use digital mode to read the CD. The Player has automatically switched the CD drive to analog mode. To switch back to digital mode, use the Devices tab. For additional assistance, click Web Help.')

    # (0xc00d11f9) No CD track was specified for playback.
    NS_E_CD_EMPTY_TRACK_QUEUE = HResultCode.new('NS_E_CD_EMPTY_TRACK_QUEUE', 0xc00d11f9, 'No CD track was specified for playback.')

    # (0xc00d11fa) The CD filter was not able to create the CD reader.
    NS_E_CD_NO_READER = HResultCode.new('NS_E_CD_NO_READER', 0xc00d11fa, 'The CD filter was not able to create the CD reader.')

    # (0xc00d11fb) Invalid ISRC code.
    NS_E_CD_ISRC_INVALID = HResultCode.new('NS_E_CD_ISRC_INVALID', 0xc00d11fb, 'Invalid ISRC code.')

    # (0xc00d11fc) Invalid Media Catalog Number.
    NS_E_CD_MEDIA_CATALOG_NUMBER_INVALID = HResultCode.new('NS_E_CD_MEDIA_CATALOG_NUMBER_INVALID', 0xc00d11fc, 'Invalid Media Catalog Number.')

    # (0xc00d11fd) Windows Media Player cannot play audio CDs correctly because the CD drive is slow and error correction is turned on. To increase performance, turn off playback error correction for this drive.
    NS_E_SLOW_READ_DIGITAL_WITH_ERRORCORRECTION = HResultCode.new('NS_E_SLOW_READ_DIGITAL_WITH_ERRORCORRECTION', 0xc00d11fd, 'Windows Media Player cannot play audio CDs correctly because the CD drive is slow and error correction is turned on. To increase performance, turn off playback error correction for this drive.')

    # (0xc00d11fe) Windows Media Player cannot estimate the CD drive's playback speed because the CD track is too short.
    NS_E_CD_SPEEDDETECT_NOT_ENOUGH_READS = HResultCode.new('NS_E_CD_SPEEDDETECT_NOT_ENOUGH_READS', 0xc00d11fe, 'Windows Media Player cannot estimate the CD drive\'s playback speed because the CD track is too short.')

    # (0xc00d11ff) Cannot queue the CD track because queuing is not enabled.
    NS_E_CD_QUEUEING_DISABLED = HResultCode.new('NS_E_CD_QUEUEING_DISABLED', 0xc00d11ff, 'Cannot queue the CD track because queuing is not enabled.')

    # (0xc00d1202) Windows Media Player cannot download additional media usage rights until the current download is complete.
    NS_E_WMP_DRM_ACQUIRING_LICENSE = HResultCode.new('NS_E_WMP_DRM_ACQUIRING_LICENSE', 0xc00d1202, 'Windows Media Player cannot download additional media usage rights until the current download is complete.')

    # (0xc00d1203) The media usage rights for this file have expired or are no longer valid. If you obtained the file from an online store, sign in to the store, and then try again.
    NS_E_WMP_DRM_LICENSE_EXPIRED = HResultCode.new('NS_E_WMP_DRM_LICENSE_EXPIRED', 0xc00d1203, 'The media usage rights for this file have expired or are no longer valid. If you obtained the file from an online store, sign in to the store, and then try again.')

    # (0xc00d1204) Windows Media Player cannot download the media usage rights for the file. If you obtained the file from an online store, sign in to the store, and then try again.
    NS_E_WMP_DRM_LICENSE_NOTACQUIRED = HResultCode.new('NS_E_WMP_DRM_LICENSE_NOTACQUIRED', 0xc00d1204, 'Windows Media Player cannot download the media usage rights for the file. If you obtained the file from an online store, sign in to the store, and then try again.')

    # (0xc00d1205) The media usage rights for this file are not yet valid. To see when they will become valid, right-click the file in the library, click Properties, and then click the Media Usage Rights tab.
    NS_E_WMP_DRM_LICENSE_NOTENABLED = HResultCode.new('NS_E_WMP_DRM_LICENSE_NOTENABLED', 0xc00d1205, 'The media usage rights for this file are not yet valid. To see when they will become valid, right-click the file in the library, click Properties, and then click the Media Usage Rights tab.')

    # (0xc00d1206) The media usage rights for this file are not valid. If you obtained this file from an online store, contact the store for assistance.
    NS_E_WMP_DRM_LICENSE_UNUSABLE = HResultCode.new('NS_E_WMP_DRM_LICENSE_UNUSABLE', 0xc00d1206, 'The media usage rights for this file are not valid. If you obtained this file from an online store, contact the store for assistance.')

    # (0xc00d1207) The content provider has revoked the media usage rights for this file. If you obtained this file from an online store, ask the store if a new version of the file is available.
    NS_E_WMP_DRM_LICENSE_CONTENT_REVOKED = HResultCode.new('NS_E_WMP_DRM_LICENSE_CONTENT_REVOKED', 0xc00d1207, 'The content provider has revoked the media usage rights for this file. If you obtained this file from an online store, ask the store if a new version of the file is available.')

    # (0xc00d1208) The media usage rights for this file require a feature that is not supported in your current version of Windows Media Player or your current version of Windows. Try installing the latest version of the Player. If you obtained this file from an online store, contact the store for further assistance.
    NS_E_WMP_DRM_LICENSE_NOSAP = HResultCode.new('NS_E_WMP_DRM_LICENSE_NOSAP', 0xc00d1208, 'The media usage rights for this file require a feature that is not supported in your current version of Windows Media Player or your current version of Windows. Try installing the latest version of the Player. If you obtained this file from an online store, contact the store for further assistance.')

    # (0xc00d1209) Windows Media Player cannot download media usage rights at this time. Try again later.
    NS_E_WMP_DRM_UNABLE_TO_ACQUIRE_LICENSE = HResultCode.new('NS_E_WMP_DRM_UNABLE_TO_ACQUIRE_LICENSE', 0xc00d1209, 'Windows Media Player cannot download media usage rights at this time. Try again later.')

    # (0xc00d120a) Windows Media Player cannot play, burn, or sync the file because the media usage rights are missing. If you obtained the file from an online store, sign in to the store, and then try again.
    NS_E_WMP_LICENSE_REQUIRED = HResultCode.new('NS_E_WMP_LICENSE_REQUIRED', 0xc00d120a, 'Windows Media Player cannot play, burn, or sync the file because the media usage rights are missing. If you obtained the file from an online store, sign in to the store, and then try again.')

    # (0xc00d120b) Windows Media Player cannot play, burn, or sync the file because the media usage rights are missing. If you obtained the file from an online store, sign in to the store, and then try again.
    NS_E_WMP_PROTECTED_CONTENT = HResultCode.new('NS_E_WMP_PROTECTED_CONTENT', 0xc00d120b, 'Windows Media Player cannot play, burn, or sync the file because the media usage rights are missing. If you obtained the file from an online store, sign in to the store, and then try again.')

    # (0xc00d122a) Windows Media Player cannot read a policy. This can occur when the policy does not exist in the registry or when the registry cannot be read.
    NS_E_WMP_POLICY_VALUE_NOT_CONFIGURED = HResultCode.new('NS_E_WMP_POLICY_VALUE_NOT_CONFIGURED', 0xc00d122a, 'Windows Media Player cannot read a policy. This can occur when the policy does not exist in the registry or when the registry cannot be read.')

    # (0xc00d1234) Windows Media Player cannot sync content streamed directly from the Internet. If possible, download the file to your computer, and then try to sync the file.
    NS_E_PDA_CANNOT_SYNC_FROM_INTERNET = HResultCode.new('NS_E_PDA_CANNOT_SYNC_FROM_INTERNET', 0xc00d1234, 'Windows Media Player cannot sync content streamed directly from the Internet. If possible, download the file to your computer, and then try to sync the file.')

    # (0xc00d1235) This playlist is not valid or is corrupted. Create a new playlist using Windows Media Player, then sync the new playlist instead.
    NS_E_PDA_CANNOT_SYNC_INVALID_PLAYLIST = HResultCode.new('NS_E_PDA_CANNOT_SYNC_INVALID_PLAYLIST', 0xc00d1235, 'This playlist is not valid or is corrupted. Create a new playlist using Windows Media Player, then sync the new playlist instead.')

    # (0xc00d1236) Windows Media Player encountered a problem while synchronizing the file to the device. For additional assistance, click Web Help.
    NS_E_PDA_FAILED_TO_SYNCHRONIZE_FILE = HResultCode.new('NS_E_PDA_FAILED_TO_SYNCHRONIZE_FILE', 0xc00d1236, 'Windows Media Player encountered a problem while synchronizing the file to the device. For additional assistance, click Web Help.')

    # (0xc00d1237) Windows Media Player encountered an error while synchronizing to the device.
    NS_E_PDA_SYNC_FAILED = HResultCode.new('NS_E_PDA_SYNC_FAILED', 0xc00d1237, 'Windows Media Player encountered an error while synchronizing to the device.')

    # (0xc00d1238) Windows Media Player cannot delete a file from the device.
    NS_E_PDA_DELETE_FAILED = HResultCode.new('NS_E_PDA_DELETE_FAILED', 0xc00d1238, 'Windows Media Player cannot delete a file from the device.')

    # (0xc00d1239) Windows Media Player cannot copy a file from the device to your library.
    NS_E_PDA_FAILED_TO_RETRIEVE_FILE = HResultCode.new('NS_E_PDA_FAILED_TO_RETRIEVE_FILE', 0xc00d1239, 'Windows Media Player cannot copy a file from the device to your library.')

    # (0xc00d123a) Windows Media Player cannot communicate with the device because the device is not responding. Try reconnecting the device, resetting the device, or contacting the device manufacturer for updated firmware.
    NS_E_PDA_DEVICE_NOT_RESPONDING = HResultCode.new('NS_E_PDA_DEVICE_NOT_RESPONDING', 0xc00d123a, 'Windows Media Player cannot communicate with the device because the device is not responding. Try reconnecting the device, resetting the device, or contacting the device manufacturer for updated firmware.')

    # (0xc00d123b) Windows Media Player cannot sync the picture to the device because a problem occurred while converting the file to another quality level or format. The original file might be damaged or corrupted.
    NS_E_PDA_FAILED_TO_TRANSCODE_PHOTO = HResultCode.new('NS_E_PDA_FAILED_TO_TRANSCODE_PHOTO', 0xc00d123b, 'Windows Media Player cannot sync the picture to the device because a problem occurred while converting the file to another quality level or format. The original file might be damaged or corrupted.')

    # (0xc00d123c) Windows Media Player cannot convert the file. The file might have been encrypted by the Encrypted File System (EFS). Try decrypting the file first and then synchronizing it. For information about how to decrypt a file, see Windows Help and Support.
    NS_E_PDA_FAILED_TO_ENCRYPT_TRANSCODED_FILE = HResultCode.new('NS_E_PDA_FAILED_TO_ENCRYPT_TRANSCODED_FILE', 0xc00d123c, 'Windows Media Player cannot convert the file. The file might have been encrypted by the Encrypted File System (EFS). Try decrypting the file first and then synchronizing it. For information about how to decrypt a file, see Windows Help and Support.')

    # (0xc00d123d) Your device requires that this file be converted in order to play on the device. However, the device either does not support playing audio, or Windows Media Player cannot convert the file to an audio format that is supported by the device.
    NS_E_PDA_CANNOT_TRANSCODE_TO_AUDIO = HResultCode.new('NS_E_PDA_CANNOT_TRANSCODE_TO_AUDIO', 0xc00d123d, 'Your device requires that this file be converted in order to play on the device. However, the device either does not support playing audio, or Windows Media Player cannot convert the file to an audio format that is supported by the device.')

    # (0xc00d123e) Your device requires that this file be converted in order to play on the device. However, the device either does not support playing video, or Windows Media Player cannot convert the file to a video format that is supported by the device.
    NS_E_PDA_CANNOT_TRANSCODE_TO_VIDEO = HResultCode.new('NS_E_PDA_CANNOT_TRANSCODE_TO_VIDEO', 0xc00d123e, 'Your device requires that this file be converted in order to play on the device. However, the device either does not support playing video, or Windows Media Player cannot convert the file to a video format that is supported by the device.')

    # (0xc00d123f) Your device requires that this file be converted in order to play on the device. However, the device either does not support displaying pictures, or Windows Media Player cannot convert the file to a picture format that is supported by the device.
    NS_E_PDA_CANNOT_TRANSCODE_TO_IMAGE = HResultCode.new('NS_E_PDA_CANNOT_TRANSCODE_TO_IMAGE', 0xc00d123f, 'Your device requires that this file be converted in order to play on the device. However, the device either does not support displaying pictures, or Windows Media Player cannot convert the file to a picture format that is supported by the device.')

    # (0xc00d1240) Windows Media Player cannot sync the file to your computer because the file name is too long. Try renaming the file on the device.
    NS_E_PDA_RETRIEVED_FILE_FILENAME_TOO_LONG = HResultCode.new('NS_E_PDA_RETRIEVED_FILE_FILENAME_TOO_LONG', 0xc00d1240, 'Windows Media Player cannot sync the file to your computer because the file name is too long. Try renaming the file on the device.')

    # (0xc00d1241) Windows Media Player cannot sync the file because the device is not responding. This typically occurs when there is a problem with the device firmware. For additional assistance, click Web Help.
    NS_E_PDA_CEWMDM_DRM_ERROR = HResultCode.new('NS_E_PDA_CEWMDM_DRM_ERROR', 0xc00d1241, 'Windows Media Player cannot sync the file because the device is not responding. This typically occurs when there is a problem with the device firmware. For additional assistance, click Web Help.')

    # (0xc00d1242) Incomplete playlist.
    NS_E_INCOMPLETE_PLAYLIST = HResultCode.new('NS_E_INCOMPLETE_PLAYLIST', 0xc00d1242, 'Incomplete playlist.')

    # (0xc00d1243) It is not possible to perform the requested action because sync is in progress. You can either stop sync or wait for it to complete, and then try again.
    NS_E_PDA_SYNC_RUNNING = HResultCode.new('NS_E_PDA_SYNC_RUNNING', 0xc00d1243, 'It is not possible to perform the requested action because sync is in progress. You can either stop sync or wait for it to complete, and then try again.')

    # (0xc00d1244) Windows Media Player cannot sync the subscription content because you are not signed in to the online store that provided it. Sign in to the online store, and then try again.
    NS_E_PDA_SYNC_LOGIN_ERROR = HResultCode.new('NS_E_PDA_SYNC_LOGIN_ERROR', 0xc00d1244, 'Windows Media Player cannot sync the subscription content because you are not signed in to the online store that provided it. Sign in to the online store, and then try again.')

    # (0xc00d1245) Windows Media Player cannot convert the file to the format required by the device. One or more codecs required to convert the file could not be found.
    NS_E_PDA_TRANSCODE_CODEC_NOT_FOUND = HResultCode.new('NS_E_PDA_TRANSCODE_CODEC_NOT_FOUND', 0xc00d1245, 'Windows Media Player cannot convert the file to the format required by the device. One or more codecs required to convert the file could not be found.')

    # (0xc00d1246) It is not possible to sync subscription files to this device.
    NS_E_CANNOT_SYNC_DRM_TO_NON_JANUS_DEVICE = HResultCode.new('NS_E_CANNOT_SYNC_DRM_TO_NON_JANUS_DEVICE', 0xc00d1246, 'It is not possible to sync subscription files to this device.')

    # (0xc00d1247) Your device is operating slowly or is not responding. Until the device responds, it is not possible to sync again. To return the device to normal operation, try disconnecting it from the computer or resetting it.
    NS_E_CANNOT_SYNC_PREVIOUS_SYNC_RUNNING = HResultCode.new('NS_E_CANNOT_SYNC_PREVIOUS_SYNC_RUNNING', 0xc00d1247, 'Your device is operating slowly or is not responding. Until the device responds, it is not possible to sync again. To return the device to normal operation, try disconnecting it from the computer or resetting it.')

    # (0xc00d125c) The Windows Media Player download manager cannot function properly because the Player main window cannot be found. Try restarting the Player.
    NS_E_WMP_HWND_NOTFOUND = HResultCode.new('NS_E_WMP_HWND_NOTFOUND', 0xc00d125c, 'The Windows Media Player download manager cannot function properly because the Player main window cannot be found. Try restarting the Player.')

    # (0xc00d125d) Windows Media Player encountered a download that has the wrong number of files. This might occur if another program is trying to create jobs with the same signature as the Player.
    NS_E_BKGDOWNLOAD_WRONG_NO_FILES = HResultCode.new('NS_E_BKGDOWNLOAD_WRONG_NO_FILES', 0xc00d125d, 'Windows Media Player encountered a download that has the wrong number of files. This might occur if another program is trying to create jobs with the same signature as the Player.')

    # (0xc00d125e) Windows Media Player tried to complete a download that was already canceled. The file will not be available.
    NS_E_BKGDOWNLOAD_COMPLETECANCELLEDJOB = HResultCode.new('NS_E_BKGDOWNLOAD_COMPLETECANCELLEDJOB', 0xc00d125e, 'Windows Media Player tried to complete a download that was already canceled. The file will not be available.')

    # (0xc00d125f) Windows Media Player tried to cancel a download that was already completed. The file will not be removed.
    NS_E_BKGDOWNLOAD_CANCELCOMPLETEDJOB = HResultCode.new('NS_E_BKGDOWNLOAD_CANCELCOMPLETEDJOB', 0xc00d125f, 'Windows Media Player tried to cancel a download that was already completed. The file will not be removed.')

    # (0xc00d1260) Windows Media Player is trying to access a download that is not valid.
    NS_E_BKGDOWNLOAD_NOJOBPOINTER = HResultCode.new('NS_E_BKGDOWNLOAD_NOJOBPOINTER', 0xc00d1260, 'Windows Media Player is trying to access a download that is not valid.')

    # (0xc00d1261) This download was not created by Windows Media Player.
    NS_E_BKGDOWNLOAD_INVALIDJOBSIGNATURE = HResultCode.new('NS_E_BKGDOWNLOAD_INVALIDJOBSIGNATURE', 0xc00d1261, 'This download was not created by Windows Media Player.')

    # (0xc00d1262) The Windows Media Player download manager cannot create a temporary file name. This might occur if the path is not valid or if the disk is full.
    NS_E_BKGDOWNLOAD_FAILED_TO_CREATE_TEMPFILE = HResultCode.new('NS_E_BKGDOWNLOAD_FAILED_TO_CREATE_TEMPFILE', 0xc00d1262, 'The Windows Media Player download manager cannot create a temporary file name. This might occur if the path is not valid or if the disk is full.')

    # (0xc00d1263) The Windows Media Player download manager plug-in cannot start. This might occur if the system is out of resources.
    NS_E_BKGDOWNLOAD_PLUGIN_FAILEDINITIALIZE = HResultCode.new('NS_E_BKGDOWNLOAD_PLUGIN_FAILEDINITIALIZE', 0xc00d1263, 'The Windows Media Player download manager plug-in cannot start. This might occur if the system is out of resources.')

    # (0xc00d1264) The Windows Media Player download manager cannot move the file.
    NS_E_BKGDOWNLOAD_PLUGIN_FAILEDTOMOVEFILE = HResultCode.new('NS_E_BKGDOWNLOAD_PLUGIN_FAILEDTOMOVEFILE', 0xc00d1264, 'The Windows Media Player download manager cannot move the file.')

    # (0xc00d1265) The Windows Media Player download manager cannot perform a task because the system has no resources to allocate.
    NS_E_BKGDOWNLOAD_CALLFUNCFAILED = HResultCode.new('NS_E_BKGDOWNLOAD_CALLFUNCFAILED', 0xc00d1265, 'The Windows Media Player download manager cannot perform a task because the system has no resources to allocate.')

    # (0xc00d1266) The Windows Media Player download manager cannot perform a task because the task took too long to run.
    NS_E_BKGDOWNLOAD_CALLFUNCTIMEOUT = HResultCode.new('NS_E_BKGDOWNLOAD_CALLFUNCTIMEOUT', 0xc00d1266, 'The Windows Media Player download manager cannot perform a task because the task took too long to run.')

    # (0xc00d1267) The Windows Media Player download manager cannot perform a task because the Player is terminating the service. The task will be recovered when the Player restarts.
    NS_E_BKGDOWNLOAD_CALLFUNCENDED = HResultCode.new('NS_E_BKGDOWNLOAD_CALLFUNCENDED', 0xc00d1267, 'The Windows Media Player download manager cannot perform a task because the Player is terminating the service. The task will be recovered when the Player restarts.')

    # (0xc00d1268) The Windows Media Player download manager cannot expand a WMD file. The file will be deleted and the operation will not be completed successfully.
    NS_E_BKGDOWNLOAD_WMDUNPACKFAILED = HResultCode.new('NS_E_BKGDOWNLOAD_WMDUNPACKFAILED', 0xc00d1268, 'The Windows Media Player download manager cannot expand a WMD file. The file will be deleted and the operation will not be completed successfully.')

    # (0xc00d1269) The Windows Media Player download manager cannot start. This might occur if the system is out of resources.
    NS_E_BKGDOWNLOAD_FAILEDINITIALIZE = HResultCode.new('NS_E_BKGDOWNLOAD_FAILEDINITIALIZE', 0xc00d1269, 'The Windows Media Player download manager cannot start. This might occur if the system is out of resources.')

    # (0xc00d126a) Windows Media Player cannot access a required functionality. This might occur if the wrong system files or Player DLLs are loaded.
    NS_E_INTERFACE_NOT_REGISTERED_IN_GIT = HResultCode.new('NS_E_INTERFACE_NOT_REGISTERED_IN_GIT', 0xc00d126a, 'Windows Media Player cannot access a required functionality. This might occur if the wrong system files or Player DLLs are loaded.')

    # (0xc00d126b) Windows Media Player cannot get the file name of the requested download. The requested download will be canceled.
    NS_E_BKGDOWNLOAD_INVALID_FILE_NAME = HResultCode.new('NS_E_BKGDOWNLOAD_INVALID_FILE_NAME', 0xc00d126b, 'Windows Media Player cannot get the file name of the requested download. The requested download will be canceled.')

    # (0xc00d128e) Windows Media Player encountered an error while downloading an image.
    NS_E_IMAGE_DOWNLOAD_FAILED = HResultCode.new('NS_E_IMAGE_DOWNLOAD_FAILED', 0xc00d128e, 'Windows Media Player encountered an error while downloading an image.')

    # (0xc00d12c0) Windows Media Player cannot update your media usage rights because the Player cannot verify the list of activated users of this computer.
    NS_E_WMP_UDRM_NOUSERLIST = HResultCode.new('NS_E_WMP_UDRM_NOUSERLIST', 0xc00d12c0, 'Windows Media Player cannot update your media usage rights because the Player cannot verify the list of activated users of this computer.')

    # (0xc00d12c1) Windows Media Player is trying to acquire media usage rights for a file that is no longer being used. Rights acquisition will stop.
    NS_E_WMP_DRM_NOT_ACQUIRING = HResultCode.new('NS_E_WMP_DRM_NOT_ACQUIRING', 0xc00d12c1, 'Windows Media Player is trying to acquire media usage rights for a file that is no longer being used. Rights acquisition will stop.')

    # (0xc00d12f2) The parameter is not valid.
    NS_E_WMP_BSTR_TOO_LONG = HResultCode.new('NS_E_WMP_BSTR_TOO_LONG', 0xc00d12f2, 'The parameter is not valid.')

    # (0xc00d12fc) The state is not valid for this request.
    NS_E_WMP_AUTOPLAY_INVALID_STATE = HResultCode.new('NS_E_WMP_AUTOPLAY_INVALID_STATE', 0xc00d12fc, 'The state is not valid for this request.')

    # (0xc00d1306) Windows Media Player cannot play this file until you complete the software component upgrade. After the component has been upgraded, try to play the file again.
    NS_E_WMP_COMPONENT_REVOKED = HResultCode.new('NS_E_WMP_COMPONENT_REVOKED', 0xc00d1306, 'Windows Media Player cannot play this file until you complete the software component upgrade. After the component has been upgraded, try to play the file again.')

    # (0xc00d1324) The URL is not safe for the operation specified.
    NS_E_CURL_NOTSAFE = HResultCode.new('NS_E_CURL_NOTSAFE', 0xc00d1324, 'The URL is not safe for the operation specified.')

    # (0xc00d1325) The URL contains one or more characters that are not valid.
    NS_E_CURL_INVALIDCHAR = HResultCode.new('NS_E_CURL_INVALIDCHAR', 0xc00d1325, 'The URL contains one or more characters that are not valid.')

    # (0xc00d1326) The URL contains a host name that is not valid.
    NS_E_CURL_INVALIDHOSTNAME = HResultCode.new('NS_E_CURL_INVALIDHOSTNAME', 0xc00d1326, 'The URL contains a host name that is not valid.')

    # (0xc00d1327) The URL contains a path that is not valid.
    NS_E_CURL_INVALIDPATH = HResultCode.new('NS_E_CURL_INVALIDPATH', 0xc00d1327, 'The URL contains a path that is not valid.')

    # (0xc00d1328) The URL contains a scheme that is not valid.
    NS_E_CURL_INVALIDSCHEME = HResultCode.new('NS_E_CURL_INVALIDSCHEME', 0xc00d1328, 'The URL contains a scheme that is not valid.')

    # (0xc00d1329) The URL is not valid.
    NS_E_CURL_INVALIDURL = HResultCode.new('NS_E_CURL_INVALIDURL', 0xc00d1329, 'The URL is not valid.')

    # (0xc00d132b) Windows Media Player cannot play the file. If you clicked a link on a web page, the link might not be valid.
    NS_E_CURL_CANTWALK = HResultCode.new('NS_E_CURL_CANTWALK', 0xc00d132b, 'Windows Media Player cannot play the file. If you clicked a link on a web page, the link might not be valid.')

    # (0xc00d132c) The URL port is not valid.
    NS_E_CURL_INVALIDPORT = HResultCode.new('NS_E_CURL_INVALIDPORT', 0xc00d132c, 'The URL port is not valid.')

    # (0xc00d132d) The URL is not a directory.
    NS_E_CURLHELPER_NOTADIRECTORY = HResultCode.new('NS_E_CURLHELPER_NOTADIRECTORY', 0xc00d132d, 'The URL is not a directory.')

    # (0xc00d132e) The URL is not a file.
    NS_E_CURLHELPER_NOTAFILE = HResultCode.new('NS_E_CURLHELPER_NOTAFILE', 0xc00d132e, 'The URL is not a file.')

    # (0xc00d132f) The URL contains characters that cannot be decoded. The URL might be truncated or incomplete.
    NS_E_CURL_CANTDECODE = HResultCode.new('NS_E_CURL_CANTDECODE', 0xc00d132f, 'The URL contains characters that cannot be decoded. The URL might be truncated or incomplete.')

    # (0xc00d1330) The specified URL is not a relative URL.
    NS_E_CURLHELPER_NOTRELATIVE = HResultCode.new('NS_E_CURLHELPER_NOTRELATIVE', 0xc00d1330, 'The specified URL is not a relative URL.')

    # (0xc00d1331) The buffer is smaller than the size specified.
    NS_E_CURL_INVALIDBUFFERSIZE = HResultCode.new('NS_E_CURL_INVALIDBUFFERSIZE', 0xc00d1331, 'The buffer is smaller than the size specified.')

    # (0xc00d1356) The content provider has not granted you the right to play this file. Go to the content provider's online store to get play rights.
    NS_E_SUBSCRIPTIONSERVICE_PLAYBACK_DISALLOWED = HResultCode.new('NS_E_SUBSCRIPTIONSERVICE_PLAYBACK_DISALLOWED', 0xc00d1356, 'The content provider has not granted you the right to play this file. Go to the content provider\'s online store to get play rights.')

    # (0xc00d1357) Windows Media Player cannot purchase or download content from multiple online stores.
    NS_E_CANNOT_BUY_OR_DOWNLOAD_FROM_MULTIPLE_SERVICES = HResultCode.new('NS_E_CANNOT_BUY_OR_DOWNLOAD_FROM_MULTIPLE_SERVICES', 0xc00d1357, 'Windows Media Player cannot purchase or download content from multiple online stores.')

    # (0xc00d1358) The file cannot be purchased or downloaded. The file might not be available from the online store.
    NS_E_CANNOT_BUY_OR_DOWNLOAD_CONTENT = HResultCode.new('NS_E_CANNOT_BUY_OR_DOWNLOAD_CONTENT', 0xc00d1358, 'The file cannot be purchased or downloaded. The file might not be available from the online store.')

    # (0xc00d135a) The provider of this file cannot be identified.
    NS_E_NOT_CONTENT_PARTNER_TRACK = HResultCode.new('NS_E_NOT_CONTENT_PARTNER_TRACK', 0xc00d135a, 'The provider of this file cannot be identified.')

    # (0xc00d135b) The file is only available for download when you buy the entire album.
    NS_E_TRACK_DOWNLOAD_REQUIRES_ALBUM_PURCHASE = HResultCode.new('NS_E_TRACK_DOWNLOAD_REQUIRES_ALBUM_PURCHASE', 0xc00d135b, 'The file is only available for download when you buy the entire album.')

    # (0xc00d135c) You must buy the file before you can download it.
    NS_E_TRACK_DOWNLOAD_REQUIRES_PURCHASE = HResultCode.new('NS_E_TRACK_DOWNLOAD_REQUIRES_PURCHASE', 0xc00d135c, 'You must buy the file before you can download it.')

    # (0xc00d135d) You have exceeded the maximum number of files that can be purchased in a single transaction.
    NS_E_TRACK_PURCHASE_MAXIMUM_EXCEEDED = HResultCode.new('NS_E_TRACK_PURCHASE_MAXIMUM_EXCEEDED', 0xc00d135d, 'You have exceeded the maximum number of files that can be purchased in a single transaction.')

    # (0xc00d135f) Windows Media Player cannot sign in to the online store. Verify that you are using the correct user name and password. If the problem persists, the store might be temporarily unavailable.
    NS_E_SUBSCRIPTIONSERVICE_LOGIN_FAILED = HResultCode.new('NS_E_SUBSCRIPTIONSERVICE_LOGIN_FAILED', 0xc00d135f, 'Windows Media Player cannot sign in to the online store. Verify that you are using the correct user name and password. If the problem persists, the store might be temporarily unavailable.')

    # (0xc00d1360) Windows Media Player cannot download this item because the server is not responding. The server might be temporarily unavailable or the Internet connection might be lost.
    NS_E_SUBSCRIPTIONSERVICE_DOWNLOAD_TIMEOUT = HResultCode.new('NS_E_SUBSCRIPTIONSERVICE_DOWNLOAD_TIMEOUT', 0xc00d1360, 'Windows Media Player cannot download this item because the server is not responding. The server might be temporarily unavailable or the Internet connection might be lost.')

    # (0xc00d1362) Content Partner still initializing.
    NS_E_CONTENT_PARTNER_STILL_INITIALIZING = HResultCode.new('NS_E_CONTENT_PARTNER_STILL_INITIALIZING', 0xc00d1362, 'Content Partner still initializing.')

    # (0xc00d1363) The folder could not be opened. The folder might have been moved or deleted.
    NS_E_OPEN_CONTAINING_FOLDER_FAILED = HResultCode.new('NS_E_OPEN_CONTAINING_FOLDER_FAILED', 0xc00d1363, 'The folder could not be opened. The folder might have been moved or deleted.')

    # (0xc00d136a) Windows Media Player could not add all of the images to the file because the images exceeded the 7 megabyte (MB) limit.
    NS_E_ADVANCEDEDIT_TOO_MANY_PICTURES = HResultCode.new('NS_E_ADVANCEDEDIT_TOO_MANY_PICTURES', 0xc00d136a, 'Windows Media Player could not add all of the images to the file because the images exceeded the 7 megabyte (MB) limit.')

    # (0xc00d1388) The client redirected to another server.
    NS_E_REDIRECT = HResultCode.new('NS_E_REDIRECT', 0xc00d1388, 'The client redirected to another server.')

    # (0xc00d1389) The streaming media description is no longer current.
    NS_E_STALE_PRESENTATION = HResultCode.new('NS_E_STALE_PRESENTATION', 0xc00d1389, 'The streaming media description is no longer current.')

    # (0xc00d138a) It is not possible to create a persistent namespace node under a transient parent node.
    NS_E_NAMESPACE_WRONG_PERSIST = HResultCode.new('NS_E_NAMESPACE_WRONG_PERSIST', 0xc00d138a, 'It is not possible to create a persistent namespace node under a transient parent node.')

    # (0xc00d138b) It is not possible to store a value in a namespace node that has a different value type.
    NS_E_NAMESPACE_WRONG_TYPE = HResultCode.new('NS_E_NAMESPACE_WRONG_TYPE', 0xc00d138b, 'It is not possible to store a value in a namespace node that has a different value type.')

    # (0xc00d138c) It is not possible to remove the root namespace node.
    NS_E_NAMESPACE_NODE_CONFLICT = HResultCode.new('NS_E_NAMESPACE_NODE_CONFLICT', 0xc00d138c, 'It is not possible to remove the root namespace node.')

    # (0xc00d138d) The specified namespace node could not be found.
    NS_E_NAMESPACE_NODE_NOT_FOUND = HResultCode.new('NS_E_NAMESPACE_NODE_NOT_FOUND', 0xc00d138d, 'The specified namespace node could not be found.')

    # (0xc00d138e) The buffer supplied to hold namespace node string is too small.
    NS_E_NAMESPACE_BUFFER_TOO_SMALL = HResultCode.new('NS_E_NAMESPACE_BUFFER_TOO_SMALL', 0xc00d138e, 'The buffer supplied to hold namespace node string is too small.')

    # (0xc00d138f) The callback list on a namespace node is at the maximum size.
    NS_E_NAMESPACE_TOO_MANY_CALLBACKS = HResultCode.new('NS_E_NAMESPACE_TOO_MANY_CALLBACKS', 0xc00d138f, 'The callback list on a namespace node is at the maximum size.')

    # (0xc00d1390) It is not possible to register an already-registered callback on a namespace node.
    NS_E_NAMESPACE_DUPLICATE_CALLBACK = HResultCode.new('NS_E_NAMESPACE_DUPLICATE_CALLBACK', 0xc00d1390, 'It is not possible to register an already-registered callback on a namespace node.')

    # (0xc00d1391) Cannot find the callback in the namespace when attempting to remove the callback.
    NS_E_NAMESPACE_CALLBACK_NOT_FOUND = HResultCode.new('NS_E_NAMESPACE_CALLBACK_NOT_FOUND', 0xc00d1391, 'Cannot find the callback in the namespace when attempting to remove the callback.')

    # (0xc00d1392) The namespace node name exceeds the allowed maximum length.
    NS_E_NAMESPACE_NAME_TOO_LONG = HResultCode.new('NS_E_NAMESPACE_NAME_TOO_LONG', 0xc00d1392, 'The namespace node name exceeds the allowed maximum length.')

    # (0xc00d1393) Cannot create a namespace node that already exists.
    NS_E_NAMESPACE_DUPLICATE_NAME = HResultCode.new('NS_E_NAMESPACE_DUPLICATE_NAME', 0xc00d1393, 'Cannot create a namespace node that already exists.')

    # (0xc00d1394) The namespace node name cannot be a null string.
    NS_E_NAMESPACE_EMPTY_NAME = HResultCode.new('NS_E_NAMESPACE_EMPTY_NAME', 0xc00d1394, 'The namespace node name cannot be a null string.')

    # (0xc00d1395) Finding a child namespace node by index failed because the index exceeded the number of children.
    NS_E_NAMESPACE_INDEX_TOO_LARGE = HResultCode.new('NS_E_NAMESPACE_INDEX_TOO_LARGE', 0xc00d1395, 'Finding a child namespace node by index failed because the index exceeded the number of children.')

    # (0xc00d1396) The namespace node name is invalid.
    NS_E_NAMESPACE_BAD_NAME = HResultCode.new('NS_E_NAMESPACE_BAD_NAME', 0xc00d1396, 'The namespace node name is invalid.')

    # (0xc00d1397) It is not possible to store a value in a namespace node that has a different security type.
    NS_E_NAMESPACE_WRONG_SECURITY = HResultCode.new('NS_E_NAMESPACE_WRONG_SECURITY', 0xc00d1397, 'It is not possible to store a value in a namespace node that has a different security type.')

    # (0xc00d13ec) The archive request conflicts with other requests in progress.
    NS_E_CACHE_ARCHIVE_CONFLICT = HResultCode.new('NS_E_CACHE_ARCHIVE_CONFLICT', 0xc00d13ec, 'The archive request conflicts with other requests in progress.')

    # (0xc00d13ed) The specified origin server cannot be found.
    NS_E_CACHE_ORIGIN_SERVER_NOT_FOUND = HResultCode.new('NS_E_CACHE_ORIGIN_SERVER_NOT_FOUND', 0xc00d13ed, 'The specified origin server cannot be found.')

    # (0xc00d13ee) The specified origin server is not responding.
    NS_E_CACHE_ORIGIN_SERVER_TIMEOUT = HResultCode.new('NS_E_CACHE_ORIGIN_SERVER_TIMEOUT', 0xc00d13ee, 'The specified origin server is not responding.')

    # (0xc00d13ef) The internal code for HTTP status code 412 Precondition Failed due to not broadcast type.
    NS_E_CACHE_NOT_BROADCAST = HResultCode.new('NS_E_CACHE_NOT_BROADCAST', 0xc00d13ef, 'The internal code for HTTP status code 412 Precondition Failed due to not broadcast type.')

    # (0xc00d13f0) The internal code for HTTP status code 403 Forbidden due to not cacheable.
    NS_E_CACHE_CANNOT_BE_CACHED = HResultCode.new('NS_E_CACHE_CANNOT_BE_CACHED', 0xc00d13f0, 'The internal code for HTTP status code 403 Forbidden due to not cacheable.')

    # (0xc00d13f1) The internal code for HTTP status code 304 Not Modified.
    NS_E_CACHE_NOT_MODIFIED = HResultCode.new('NS_E_CACHE_NOT_MODIFIED', 0xc00d13f1, 'The internal code for HTTP status code 304 Not Modified.')

    # (0xc00d1450) It is not possible to remove a cache or proxy publishing point.
    NS_E_CANNOT_REMOVE_PUBLISHING_POINT = HResultCode.new('NS_E_CANNOT_REMOVE_PUBLISHING_POINT', 0xc00d1450, 'It is not possible to remove a cache or proxy publishing point.')

    # (0xc00d1451) It is not possible to remove the last instance of a type of plug-in.
    NS_E_CANNOT_REMOVE_PLUGIN = HResultCode.new('NS_E_CANNOT_REMOVE_PLUGIN', 0xc00d1451, 'It is not possible to remove the last instance of a type of plug-in.')

    # (0xc00d1452) Cache and proxy publishing points do not support this property or method.
    NS_E_WRONG_PUBLISHING_POINT_TYPE = HResultCode.new('NS_E_WRONG_PUBLISHING_POINT_TYPE', 0xc00d1452, 'Cache and proxy publishing points do not support this property or method.')

    # (0xc00d1453) The plug-in does not support the specified load type.
    NS_E_UNSUPPORTED_LOAD_TYPE = HResultCode.new('NS_E_UNSUPPORTED_LOAD_TYPE', 0xc00d1453, 'The plug-in does not support the specified load type.')

    # (0xc00d1454) The plug-in does not support any load types. The plug-in must support at least one load type.
    NS_E_INVALID_PLUGIN_LOAD_TYPE_CONFIGURATION = HResultCode.new('NS_E_INVALID_PLUGIN_LOAD_TYPE_CONFIGURATION', 0xc00d1454, 'The plug-in does not support any load types. The plug-in must support at least one load type.')

    # (0xc00d1455) The publishing point name is invalid.
    NS_E_INVALID_PUBLISHING_POINT_NAME = HResultCode.new('NS_E_INVALID_PUBLISHING_POINT_NAME', 0xc00d1455, 'The publishing point name is invalid.')

    # (0xc00d1456) Only one multicast data writer plug-in can be enabled for a publishing point.
    NS_E_TOO_MANY_MULTICAST_SINKS = HResultCode.new('NS_E_TOO_MANY_MULTICAST_SINKS', 0xc00d1456, 'Only one multicast data writer plug-in can be enabled for a publishing point.')

    # (0xc00d1457) The requested operation cannot be completed while the publishing point is started.
    NS_E_PUBLISHING_POINT_INVALID_REQUEST_WHILE_STARTED = HResultCode.new('NS_E_PUBLISHING_POINT_INVALID_REQUEST_WHILE_STARTED', 0xc00d1457, 'The requested operation cannot be completed while the publishing point is started.')

    # (0xc00d1458) A multicast data writer plug-in must be enabled in order for this operation to be completed.
    NS_E_MULTICAST_PLUGIN_NOT_ENABLED = HResultCode.new('NS_E_MULTICAST_PLUGIN_NOT_ENABLED', 0xc00d1458, 'A multicast data writer plug-in must be enabled in order for this operation to be completed.')

    # (0xc00d1459) This feature requires Windows Server 2003, Enterprise Edition.
    NS_E_INVALID_OPERATING_SYSTEM_VERSION = HResultCode.new('NS_E_INVALID_OPERATING_SYSTEM_VERSION', 0xc00d1459, 'This feature requires Windows Server 2003, Enterprise Edition.')

    # (0xc00d145a) The requested operation cannot be completed because the specified publishing point has been removed.
    NS_E_PUBLISHING_POINT_REMOVED = HResultCode.new('NS_E_PUBLISHING_POINT_REMOVED', 0xc00d145a, 'The requested operation cannot be completed because the specified publishing point has been removed.')

    # (0xc00d145b) Push publishing points are started when the encoder starts pushing the stream. This publishing point cannot be started by the server administrator.
    NS_E_INVALID_PUSH_PUBLISHING_POINT_START_REQUEST = HResultCode.new('NS_E_INVALID_PUSH_PUBLISHING_POINT_START_REQUEST', 0xc00d145b, 'Push publishing points are started when the encoder starts pushing the stream. This publishing point cannot be started by the server administrator.')

    # (0xc00d145c) The specified language is not supported.
    NS_E_UNSUPPORTED_LANGUAGE = HResultCode.new('NS_E_UNSUPPORTED_LANGUAGE', 0xc00d145c, 'The specified language is not supported.')

    # (0xc00d145d) Windows Media Services will only run on Windows Server 2003, Standard Edition and Windows Server 2003, Enterprise Edition.
    NS_E_WRONG_OS_VERSION = HResultCode.new('NS_E_WRONG_OS_VERSION', 0xc00d145d, 'Windows Media Services will only run on Windows Server 2003, Standard Edition and Windows Server 2003, Enterprise Edition.')

    # (0xc00d145e) The operation cannot be completed because the publishing point has been stopped.
    NS_E_PUBLISHING_POINT_STOPPED = HResultCode.new('NS_E_PUBLISHING_POINT_STOPPED', 0xc00d145e, 'The operation cannot be completed because the publishing point has been stopped.')

    # (0xc00d14b4) The playlist entry is already playing.
    NS_E_PLAYLIST_ENTRY_ALREADY_PLAYING = HResultCode.new('NS_E_PLAYLIST_ENTRY_ALREADY_PLAYING', 0xc00d14b4, 'The playlist entry is already playing.')

    # (0xc00d14b5) The playlist or directory you are requesting does not contain content.
    NS_E_EMPTY_PLAYLIST = HResultCode.new('NS_E_EMPTY_PLAYLIST', 0xc00d14b5, 'The playlist or directory you are requesting does not contain content.')

    # (0xc00d14b6) The server was unable to parse the requested playlist file.
    NS_E_PLAYLIST_PARSE_FAILURE = HResultCode.new('NS_E_PLAYLIST_PARSE_FAILURE', 0xc00d14b6, 'The server was unable to parse the requested playlist file.')

    # (0xc00d14b7) The requested operation is not supported for this type of playlist entry.
    NS_E_PLAYLIST_UNSUPPORTED_ENTRY = HResultCode.new('NS_E_PLAYLIST_UNSUPPORTED_ENTRY', 0xc00d14b7, 'The requested operation is not supported for this type of playlist entry.')

    # (0xc00d14b8) Cannot jump to a playlist entry that is not inserted in the playlist.
    NS_E_PLAYLIST_ENTRY_NOT_IN_PLAYLIST = HResultCode.new('NS_E_PLAYLIST_ENTRY_NOT_IN_PLAYLIST', 0xc00d14b8, 'Cannot jump to a playlist entry that is not inserted in the playlist.')

    # (0xc00d14b9) Cannot seek to the desired playlist entry.
    NS_E_PLAYLIST_ENTRY_SEEK = HResultCode.new('NS_E_PLAYLIST_ENTRY_SEEK', 0xc00d14b9, 'Cannot seek to the desired playlist entry.')

    # (0xc00d14ba) Cannot play recursive playlist.
    NS_E_PLAYLIST_RECURSIVE_PLAYLISTS = HResultCode.new('NS_E_PLAYLIST_RECURSIVE_PLAYLISTS', 0xc00d14ba, 'Cannot play recursive playlist.')

    # (0xc00d14bb) The number of nested playlists exceeded the limit the server can handle.
    NS_E_PLAYLIST_TOO_MANY_NESTED_PLAYLISTS = HResultCode.new('NS_E_PLAYLIST_TOO_MANY_NESTED_PLAYLISTS', 0xc00d14bb, 'The number of nested playlists exceeded the limit the server can handle.')

    # (0xc00d14bc) Cannot execute the requested operation because the playlist has been shut down by the Media Server.
    NS_E_PLAYLIST_SHUTDOWN = HResultCode.new('NS_E_PLAYLIST_SHUTDOWN', 0xc00d14bc, 'Cannot execute the requested operation because the playlist has been shut down by the Media Server.')

    # (0xc00d14bd) The playlist has ended while receding.
    NS_E_PLAYLIST_END_RECEDING = HResultCode.new('NS_E_PLAYLIST_END_RECEDING', 0xc00d14bd, 'The playlist has ended while receding.')

    # (0xc00d1518) The data path does not have an associated data writer plug-in.
    NS_E_DATAPATH_NO_SINK = HResultCode.new('NS_E_DATAPATH_NO_SINK', 0xc00d1518, 'The data path does not have an associated data writer plug-in.')

    # (0xc00d151a) The specified push template is invalid.
    NS_E_INVALID_PUSH_TEMPLATE = HResultCode.new('NS_E_INVALID_PUSH_TEMPLATE', 0xc00d151a, 'The specified push template is invalid.')

    # (0xc00d151b) The specified push publishing point is invalid.
    NS_E_INVALID_PUSH_PUBLISHING_POINT = HResultCode.new('NS_E_INVALID_PUSH_PUBLISHING_POINT', 0xc00d151b, 'The specified push publishing point is invalid.')

    # (0xc00d151c) The requested operation cannot be performed because the server or publishing point is in a critical error state.
    NS_E_CRITICAL_ERROR = HResultCode.new('NS_E_CRITICAL_ERROR', 0xc00d151c, 'The requested operation cannot be performed because the server or publishing point is in a critical error state.')

    # (0xc00d151d) The content cannot be played because the server is not currently accepting connections. Try connecting at a later time.
    NS_E_NO_NEW_CONNECTIONS = HResultCode.new('NS_E_NO_NEW_CONNECTIONS', 0xc00d151d, 'The content cannot be played because the server is not currently accepting connections. Try connecting at a later time.')

    # (0xc00d151e) The version of this playlist is not supported by the server.
    NS_E_WSX_INVALID_VERSION = HResultCode.new('NS_E_WSX_INVALID_VERSION', 0xc00d151e, 'The version of this playlist is not supported by the server.')

    # (0xc00d151f) The command does not apply to the current media header user by a server component.
    NS_E_HEADER_MISMATCH = HResultCode.new('NS_E_HEADER_MISMATCH', 0xc00d151f, 'The command does not apply to the current media header user by a server component.')

    # (0xc00d1520) The specified publishing point name is already in use.
    NS_E_PUSH_DUPLICATE_PUBLISHING_POINT_NAME = HResultCode.new('NS_E_PUSH_DUPLICATE_PUBLISHING_POINT_NAME', 0xc00d1520, 'The specified publishing point name is already in use.')

    # (0xc00d157c) There is no script engine available for this file.
    NS_E_NO_SCRIPT_ENGINE = HResultCode.new('NS_E_NO_SCRIPT_ENGINE', 0xc00d157c, 'There is no script engine available for this file.')

    # (0xc00d157d) The plug-in has reported an error. See the Troubleshooting tab or the NT Application Event Log for details.
    NS_E_PLUGIN_ERROR_REPORTED = HResultCode.new('NS_E_PLUGIN_ERROR_REPORTED', 0xc00d157d, 'The plug-in has reported an error. See the Troubleshooting tab or the NT Application Event Log for details.')

    # (0xc00d157e) No enabled data source plug-in is available to access the requested content.
    NS_E_SOURCE_PLUGIN_NOT_FOUND = HResultCode.new('NS_E_SOURCE_PLUGIN_NOT_FOUND', 0xc00d157e, 'No enabled data source plug-in is available to access the requested content.')

    # (0xc00d157f) No enabled playlist parser plug-in is available to access the requested content.
    NS_E_PLAYLIST_PLUGIN_NOT_FOUND = HResultCode.new('NS_E_PLAYLIST_PLUGIN_NOT_FOUND', 0xc00d157f, 'No enabled playlist parser plug-in is available to access the requested content.')

    # (0xc00d1580) The data source plug-in does not support enumeration.
    NS_E_DATA_SOURCE_ENUMERATION_NOT_SUPPORTED = HResultCode.new('NS_E_DATA_SOURCE_ENUMERATION_NOT_SUPPORTED', 0xc00d1580, 'The data source plug-in does not support enumeration.')

    # (0xc00d1581) The server cannot stream the selected file because it is either damaged or corrupt. Select a different file.
    NS_E_MEDIA_PARSER_INVALID_FORMAT = HResultCode.new('NS_E_MEDIA_PARSER_INVALID_FORMAT', 0xc00d1581, 'The server cannot stream the selected file because it is either damaged or corrupt. Select a different file.')

    # (0xc00d1582) The plug-in cannot be enabled because a compatible script debugger is not installed on this system. Install a script debugger, or disable the script debugger option on the general tab of the plug-in's properties page and try again.
    NS_E_SCRIPT_DEBUGGER_NOT_INSTALLED = HResultCode.new('NS_E_SCRIPT_DEBUGGER_NOT_INSTALLED', 0xc00d1582, 'The plug-in cannot be enabled because a compatible script debugger is not installed on this system. Install a script debugger, or disable the script debugger option on the general tab of the plug-in\'s properties page and try again.')

    # (0xc00d1583) The plug-in cannot be loaded because it requires Windows Server 2003, Enterprise Edition.
    NS_E_FEATURE_REQUIRES_ENTERPRISE_SERVER = HResultCode.new('NS_E_FEATURE_REQUIRES_ENTERPRISE_SERVER', 0xc00d1583, 'The plug-in cannot be loaded because it requires Windows Server 2003, Enterprise Edition.')

    # (0xc00d1584) Another wizard is currently running. Please close the other wizard or wait until it finishes before attempting to run this wizard again.
    NS_E_WIZARD_RUNNING = HResultCode.new('NS_E_WIZARD_RUNNING', 0xc00d1584, 'Another wizard is currently running. Please close the other wizard or wait until it finishes before attempting to run this wizard again.')

    # (0xc00d1585) Invalid log URL. Multicast logging URL must look like "http://servername/isapibackend.dll".
    NS_E_INVALID_LOG_URL = HResultCode.new('NS_E_INVALID_LOG_URL', 0xc00d1585, 'Invalid log URL. Multicast logging URL must look like "http://servername/isapibackend.dll".')

    # (0xc00d1586) Invalid MTU specified. The valid range for maximum packet size is between 36 and 65507 bytes.
    NS_E_INVALID_MTU_RANGE = HResultCode.new('NS_E_INVALID_MTU_RANGE', 0xc00d1586, 'Invalid MTU specified. The valid range for maximum packet size is between 36 and 65507 bytes.')

    # (0xc00d1587) Invalid play statistics for logging.
    NS_E_INVALID_PLAY_STATISTICS = HResultCode.new('NS_E_INVALID_PLAY_STATISTICS', 0xc00d1587, 'Invalid play statistics for logging.')

    # (0xc00d1588) The log needs to be skipped.
    NS_E_LOG_NEED_TO_BE_SKIPPED = HResultCode.new('NS_E_LOG_NEED_TO_BE_SKIPPED', 0xc00d1588, 'The log needs to be skipped.')

    # (0xc00d1589) The size of the data exceeded the limit the WMS HTTP Download Data Source plugin can handle.
    NS_E_HTTP_TEXT_DATACONTAINER_SIZE_LIMIT_EXCEEDED = HResultCode.new('NS_E_HTTP_TEXT_DATACONTAINER_SIZE_LIMIT_EXCEEDED', 0xc00d1589, 'The size of the data exceeded the limit the WMS HTTP Download Data Source plugin can handle.')

    # (0xc00d158a) One usage of each socket address (protocol/network address/port) is permitted. Verify that other services or applications are not attempting to use the same port and then try to enable the plug-in again.
    NS_E_PORT_IN_USE = HResultCode.new('NS_E_PORT_IN_USE', 0xc00d158a, 'One usage of each socket address (protocol/network address/port) is permitted. Verify that other services or applications are not attempting to use the same port and then try to enable the plug-in again.')

    # (0xc00d158b) One usage of each socket address (protocol/network address/port) is permitted. Verify that other services (such as IIS) or applications are not attempting to use the same port and then try to enable the plug-in again.
    NS_E_PORT_IN_USE_HTTP = HResultCode.new('NS_E_PORT_IN_USE_HTTP', 0xc00d158b, 'One usage of each socket address (protocol/network address/port) is permitted. Verify that other services (such as IIS) or applications are not attempting to use the same port and then try to enable the plug-in again.')

    # (0xc00d158c) The WMS HTTP Download Data Source plugin was unable to receive the remote server's response.
    NS_E_HTTP_TEXT_DATACONTAINER_INVALID_SERVER_RESPONSE = HResultCode.new('NS_E_HTTP_TEXT_DATACONTAINER_INVALID_SERVER_RESPONSE', 0xc00d158c, 'The WMS HTTP Download Data Source plugin was unable to receive the remote server\'s response.')

    # (0xc00d158d) The archive plug-in has reached its quota.
    NS_E_ARCHIVE_REACH_QUOTA = HResultCode.new('NS_E_ARCHIVE_REACH_QUOTA', 0xc00d158d, 'The archive plug-in has reached its quota.')

    # (0xc00d158e) The archive plug-in aborted because the source was from broadcast.
    NS_E_ARCHIVE_ABORT_DUE_TO_BCAST = HResultCode.new('NS_E_ARCHIVE_ABORT_DUE_TO_BCAST', 0xc00d158e, 'The archive plug-in aborted because the source was from broadcast.')

    # (0xc00d158f) The archive plug-in detected an interrupt in the source.
    NS_E_ARCHIVE_GAP_DETECTED = HResultCode.new('NS_E_ARCHIVE_GAP_DETECTED', 0xc00d158f, 'The archive plug-in detected an interrupt in the source.')

    # (0xc00d1590) The system cannot find the file specified.
    NS_E_AUTHORIZATION_FILE_NOT_FOUND = HResultCode.new('NS_E_AUTHORIZATION_FILE_NOT_FOUND', 0xc00d1590, 'The system cannot find the file specified.')

    # (0xc00d1b58) The mark-in time should be greater than 0 and less than the mark-out time.
    NS_E_BAD_MARKIN = HResultCode.new('NS_E_BAD_MARKIN', 0xc00d1b58, 'The mark-in time should be greater than 0 and less than the mark-out time.')

    # (0xc00d1b59) The mark-out time should be greater than the mark-in time and less than the file duration.
    NS_E_BAD_MARKOUT = HResultCode.new('NS_E_BAD_MARKOUT', 0xc00d1b59, 'The mark-out time should be greater than the mark-in time and less than the file duration.')

    # (0xc00d1b5a) No matching media type is found in the source %1.
    NS_E_NOMATCHING_MEDIASOURCE = HResultCode.new('NS_E_NOMATCHING_MEDIASOURCE', 0xc00d1b5a, 'No matching media type is found in the source %1.')

    # (0xc00d1b5b) The specified source type is not supported.
    NS_E_UNSUPPORTED_SOURCETYPE = HResultCode.new('NS_E_UNSUPPORTED_SOURCETYPE', 0xc00d1b5b, 'The specified source type is not supported.')

    # (0xc00d1b5c) It is not possible to specify more than one audio input.
    NS_E_TOO_MANY_AUDIO = HResultCode.new('NS_E_TOO_MANY_AUDIO', 0xc00d1b5c, 'It is not possible to specify more than one audio input.')

    # (0xc00d1b5d) It is not possible to specify more than two video inputs.
    NS_E_TOO_MANY_VIDEO = HResultCode.new('NS_E_TOO_MANY_VIDEO', 0xc00d1b5d, 'It is not possible to specify more than two video inputs.')

    # (0xc00d1b5e) No matching element is found in the list.
    NS_E_NOMATCHING_ELEMENT = HResultCode.new('NS_E_NOMATCHING_ELEMENT', 0xc00d1b5e, 'No matching element is found in the list.')

    # (0xc00d1b5f) The profile's media types must match the media types defined for the session.
    NS_E_MISMATCHED_MEDIACONTENT = HResultCode.new('NS_E_MISMATCHED_MEDIACONTENT', 0xc00d1b5f, 'The profile\'s media types must match the media types defined for the session.')

    # (0xc00d1b60) It is not possible to remove an active source while encoding.
    NS_E_CANNOT_DELETE_ACTIVE_SOURCEGROUP = HResultCode.new('NS_E_CANNOT_DELETE_ACTIVE_SOURCEGROUP', 0xc00d1b60, 'It is not possible to remove an active source while encoding.')

    # (0xc00d1b61) It is not possible to open the specified audio capture device because it is currently in use.
    NS_E_AUDIODEVICE_BUSY = HResultCode.new('NS_E_AUDIODEVICE_BUSY', 0xc00d1b61, 'It is not possible to open the specified audio capture device because it is currently in use.')

    # (0xc00d1b62) It is not possible to open the specified audio capture device because an unexpected error has occurred.
    NS_E_AUDIODEVICE_UNEXPECTED = HResultCode.new('NS_E_AUDIODEVICE_UNEXPECTED', 0xc00d1b62, 'It is not possible to open the specified audio capture device because an unexpected error has occurred.')

    # (0xc00d1b63) The audio capture device does not support the specified audio format.
    NS_E_AUDIODEVICE_BADFORMAT = HResultCode.new('NS_E_AUDIODEVICE_BADFORMAT', 0xc00d1b63, 'The audio capture device does not support the specified audio format.')

    # (0xc00d1b64) It is not possible to open the specified video capture device because it is currently in use.
    NS_E_VIDEODEVICE_BUSY = HResultCode.new('NS_E_VIDEODEVICE_BUSY', 0xc00d1b64, 'It is not possible to open the specified video capture device because it is currently in use.')

    # (0xc00d1b65) It is not possible to open the specified video capture device because an unexpected error has occurred.
    NS_E_VIDEODEVICE_UNEXPECTED = HResultCode.new('NS_E_VIDEODEVICE_UNEXPECTED', 0xc00d1b65, 'It is not possible to open the specified video capture device because an unexpected error has occurred.')

    # (0xc00d1b66) This operation is not allowed while encoding.
    NS_E_INVALIDCALL_WHILE_ENCODER_RUNNING = HResultCode.new('NS_E_INVALIDCALL_WHILE_ENCODER_RUNNING', 0xc00d1b66, 'This operation is not allowed while encoding.')

    # (0xc00d1b67) No profile is set for the source.
    NS_E_NO_PROFILE_IN_SOURCEGROUP = HResultCode.new('NS_E_NO_PROFILE_IN_SOURCEGROUP', 0xc00d1b67, 'No profile is set for the source.')

    # (0xc00d1b68) The video capture driver returned an unrecoverable error. It is now in an unstable state.
    NS_E_VIDEODRIVER_UNSTABLE = HResultCode.new('NS_E_VIDEODRIVER_UNSTABLE', 0xc00d1b68, 'The video capture driver returned an unrecoverable error. It is now in an unstable state.')

    # (0xc00d1b69) It was not possible to start the video device.
    NS_E_VIDCAPSTARTFAILED = HResultCode.new('NS_E_VIDCAPSTARTFAILED', 0xc00d1b69, 'It was not possible to start the video device.')

    # (0xc00d1b6a) The video source does not support the requested output format or color depth.
    NS_E_VIDSOURCECOMPRESSION = HResultCode.new('NS_E_VIDSOURCECOMPRESSION', 0xc00d1b6a, 'The video source does not support the requested output format or color depth.')

    # (0xc00d1b6b) The video source does not support the requested capture size.
    NS_E_VIDSOURCESIZE = HResultCode.new('NS_E_VIDSOURCESIZE', 0xc00d1b6b, 'The video source does not support the requested capture size.')

    # (0xc00d1b6c) It was not possible to obtain output information from the video compressor.
    NS_E_ICMQUERYFORMAT = HResultCode.new('NS_E_ICMQUERYFORMAT', 0xc00d1b6c, 'It was not possible to obtain output information from the video compressor.')

    # (0xc00d1b6d) It was not possible to create a video capture window.
    NS_E_VIDCAPCREATEWINDOW = HResultCode.new('NS_E_VIDCAPCREATEWINDOW', 0xc00d1b6d, 'It was not possible to create a video capture window.')

    # (0xc00d1b6e) There is already a stream active on this video device.
    NS_E_VIDCAPDRVINUSE = HResultCode.new('NS_E_VIDCAPDRVINUSE', 0xc00d1b6e, 'There is already a stream active on this video device.')

    # (0xc00d1b6f) No media format is set in source.
    NS_E_NO_MEDIAFORMAT_IN_SOURCE = HResultCode.new('NS_E_NO_MEDIAFORMAT_IN_SOURCE', 0xc00d1b6f, 'No media format is set in source.')

    # (0xc00d1b70) Cannot find a valid output stream from the source.
    NS_E_NO_VALID_OUTPUT_STREAM = HResultCode.new('NS_E_NO_VALID_OUTPUT_STREAM', 0xc00d1b70, 'Cannot find a valid output stream from the source.')

    # (0xc00d1b71) It was not possible to find a valid source plug-in for the specified source.
    NS_E_NO_VALID_SOURCE_PLUGIN = HResultCode.new('NS_E_NO_VALID_SOURCE_PLUGIN', 0xc00d1b71, 'It was not possible to find a valid source plug-in for the specified source.')

    # (0xc00d1b72) No source is currently active.
    NS_E_NO_ACTIVE_SOURCEGROUP = HResultCode.new('NS_E_NO_ACTIVE_SOURCEGROUP', 0xc00d1b72, 'No source is currently active.')

    # (0xc00d1b73) No script stream is set in the current source.
    NS_E_NO_SCRIPT_STREAM = HResultCode.new('NS_E_NO_SCRIPT_STREAM', 0xc00d1b73, 'No script stream is set in the current source.')

    # (0xc00d1b74) This operation is not allowed while archiving.
    NS_E_INVALIDCALL_WHILE_ARCHIVAL_RUNNING = HResultCode.new('NS_E_INVALIDCALL_WHILE_ARCHIVAL_RUNNING', 0xc00d1b74, 'This operation is not allowed while archiving.')

    # (0xc00d1b75) The setting for the maximum packet size is not valid.
    NS_E_INVALIDPACKETSIZE = HResultCode.new('NS_E_INVALIDPACKETSIZE', 0xc00d1b75, 'The setting for the maximum packet size is not valid.')

    # (0xc00d1b76) The plug-in CLSID specified is not valid.
    NS_E_PLUGIN_CLSID_INVALID = HResultCode.new('NS_E_PLUGIN_CLSID_INVALID', 0xc00d1b76, 'The plug-in CLSID specified is not valid.')

    # (0xc00d1b77) This archive type is not supported.
    NS_E_UNSUPPORTED_ARCHIVETYPE = HResultCode.new('NS_E_UNSUPPORTED_ARCHIVETYPE', 0xc00d1b77, 'This archive type is not supported.')

    # (0xc00d1b78) This archive operation is not supported.
    NS_E_UNSUPPORTED_ARCHIVEOPERATION = HResultCode.new('NS_E_UNSUPPORTED_ARCHIVEOPERATION', 0xc00d1b78, 'This archive operation is not supported.')

    # (0xc00d1b79) The local archive file name was not set.
    NS_E_ARCHIVE_FILENAME_NOTSET = HResultCode.new('NS_E_ARCHIVE_FILENAME_NOTSET', 0xc00d1b79, 'The local archive file name was not set.')

    # (0xc00d1b7a) The source is not yet prepared.
    NS_E_SOURCEGROUP_NOTPREPARED = HResultCode.new('NS_E_SOURCEGROUP_NOTPREPARED', 0xc00d1b7a, 'The source is not yet prepared.')

    # (0xc00d1b7b) Profiles on the sources do not match.
    NS_E_PROFILE_MISMATCH = HResultCode.new('NS_E_PROFILE_MISMATCH', 0xc00d1b7b, 'Profiles on the sources do not match.')

    # (0xc00d1b7c) The specified crop values are not valid.
    NS_E_INCORRECTCLIPSETTINGS = HResultCode.new('NS_E_INCORRECTCLIPSETTINGS', 0xc00d1b7c, 'The specified crop values are not valid.')

    # (0xc00d1b7d) No statistics are available at this time.
    NS_E_NOSTATSAVAILABLE = HResultCode.new('NS_E_NOSTATSAVAILABLE', 0xc00d1b7d, 'No statistics are available at this time.')

    # (0xc00d1b7e) The encoder is not archiving.
    NS_E_NOTARCHIVING = HResultCode.new('NS_E_NOTARCHIVING', 0xc00d1b7e, 'The encoder is not archiving.')

    # (0xc00d1b7f) This operation is only allowed during encoding.
    NS_E_INVALIDCALL_WHILE_ENCODER_STOPPED = HResultCode.new('NS_E_INVALIDCALL_WHILE_ENCODER_STOPPED', 0xc00d1b7f, 'This operation is only allowed during encoding.')

    # (0xc00d1b80) This SourceGroupCollection doesn't contain any SourceGroups.
    NS_E_NOSOURCEGROUPS = HResultCode.new('NS_E_NOSOURCEGROUPS', 0xc00d1b80, 'This SourceGroupCollection doesn\'t contain any SourceGroups.')

    # (0xc00d1b81) This source does not have a frame rate of 30 fps. Therefore, it is not possible to apply the inverse telecine filter to the source.
    NS_E_INVALIDINPUTFPS = HResultCode.new('NS_E_INVALIDINPUTFPS', 0xc00d1b81, 'This source does not have a frame rate of 30 fps. Therefore, it is not possible to apply the inverse telecine filter to the source.')

    # (0xc00d1b82) It is not possible to display your source or output video in the Video panel.
    NS_E_NO_DATAVIEW_SUPPORT = HResultCode.new('NS_E_NO_DATAVIEW_SUPPORT', 0xc00d1b82, 'It is not possible to display your source or output video in the Video panel.')

    # (0xc00d1b83) One or more codecs required to open this content could not be found.
    NS_E_CODEC_UNAVAILABLE = HResultCode.new('NS_E_CODEC_UNAVAILABLE', 0xc00d1b83, 'One or more codecs required to open this content could not be found.')

    # (0xc00d1b84) The archive file has the same name as an input file. Change one of the names before continuing.
    NS_E_ARCHIVE_SAME_AS_INPUT = HResultCode.new('NS_E_ARCHIVE_SAME_AS_INPUT', 0xc00d1b84, 'The archive file has the same name as an input file. Change one of the names before continuing.')

    # (0xc00d1b85) The source has not been set up completely.
    NS_E_SOURCE_NOTSPECIFIED = HResultCode.new('NS_E_SOURCE_NOTSPECIFIED', 0xc00d1b85, 'The source has not been set up completely.')

    # (0xc00d1b86) It is not possible to apply time compression to a broadcast session.
    NS_E_NO_REALTIME_TIMECOMPRESSION = HResultCode.new('NS_E_NO_REALTIME_TIMECOMPRESSION', 0xc00d1b86, 'It is not possible to apply time compression to a broadcast session.')

    # (0xc00d1b87) It is not possible to open this device.
    NS_E_UNSUPPORTED_ENCODER_DEVICE = HResultCode.new('NS_E_UNSUPPORTED_ENCODER_DEVICE', 0xc00d1b87, 'It is not possible to open this device.')

    # (0xc00d1b88) It is not possible to start encoding because the display size or color has changed since the current session was defined. Restore the previous settings or create a new session.
    NS_E_UNEXPECTED_DISPLAY_SETTINGS = HResultCode.new('NS_E_UNEXPECTED_DISPLAY_SETTINGS', 0xc00d1b88, 'It is not possible to start encoding because the display size or color has changed since the current session was defined. Restore the previous settings or create a new session.')

    # (0xc00d1b89) No audio data has been received for several seconds. Check the audio source and restart the encoder.
    NS_E_NO_AUDIODATA = HResultCode.new('NS_E_NO_AUDIODATA', 0xc00d1b89, 'No audio data has been received for several seconds. Check the audio source and restart the encoder.')

    # (0xc00d1b8a) One or all of the specified sources are not working properly. Check that the sources are configured correctly.
    NS_E_INPUTSOURCE_PROBLEM = HResultCode.new('NS_E_INPUTSOURCE_PROBLEM', 0xc00d1b8a, 'One or all of the specified sources are not working properly. Check that the sources are configured correctly.')

    # (0xc00d1b8b) The supplied configuration file is not supported by this version of the encoder.
    NS_E_WME_VERSION_MISMATCH = HResultCode.new('NS_E_WME_VERSION_MISMATCH', 0xc00d1b8b, 'The supplied configuration file is not supported by this version of the encoder.')

    # (0xc00d1b8c) It is not possible to use image preprocessing with live encoding.
    NS_E_NO_REALTIME_PREPROCESS = HResultCode.new('NS_E_NO_REALTIME_PREPROCESS', 0xc00d1b8c, 'It is not possible to use image preprocessing with live encoding.')

    # (0xc00d1b8d) It is not possible to use two-pass encoding when the source is set to loop.
    NS_E_NO_REPEAT_PREPROCESS = HResultCode.new('NS_E_NO_REPEAT_PREPROCESS', 0xc00d1b8d, 'It is not possible to use two-pass encoding when the source is set to loop.')

    # (0xc00d1b8e) It is not possible to pause encoding during a broadcast.
    NS_E_CANNOT_PAUSE_LIVEBROADCAST = HResultCode.new('NS_E_CANNOT_PAUSE_LIVEBROADCAST', 0xc00d1b8e, 'It is not possible to pause encoding during a broadcast.')

    # (0xc00d1b8f) A DRM profile has not been set for the current session.
    NS_E_DRM_PROFILE_NOT_SET = HResultCode.new('NS_E_DRM_PROFILE_NOT_SET', 0xc00d1b8f, 'A DRM profile has not been set for the current session.')

    # (0xc00d1b90) The profile ID is already used by a DRM profile. Specify a different profile ID.
    NS_E_DUPLICATE_DRMPROFILE = HResultCode.new('NS_E_DUPLICATE_DRMPROFILE', 0xc00d1b90, 'The profile ID is already used by a DRM profile. Specify a different profile ID.')

    # (0xc00d1b91) The setting of the selected device does not support control for playing back tapes.
    NS_E_INVALID_DEVICE = HResultCode.new('NS_E_INVALID_DEVICE', 0xc00d1b91, 'The setting of the selected device does not support control for playing back tapes.')

    # (0xc00d1b92) You must specify a mixed voice and audio mode in order to use an optimization definition file.
    NS_E_SPEECHEDL_ON_NON_MIXEDMODE = HResultCode.new('NS_E_SPEECHEDL_ON_NON_MIXEDMODE', 0xc00d1b92, 'You must specify a mixed voice and audio mode in order to use an optimization definition file.')

    # (0xc00d1b93) The specified password is too long. Type a password with fewer than 8 characters.
    NS_E_DRM_PASSWORD_TOO_LONG = HResultCode.new('NS_E_DRM_PASSWORD_TOO_LONG', 0xc00d1b93, 'The specified password is too long. Type a password with fewer than 8 characters.')

    # (0xc00d1b94) It is not possible to seek to the specified mark-in point.
    NS_E_DEVCONTROL_FAILED_SEEK = HResultCode.new('NS_E_DEVCONTROL_FAILED_SEEK', 0xc00d1b94, 'It is not possible to seek to the specified mark-in point.')

    # (0xc00d1b95) When you choose to maintain the interlacing in your video, the output video size must match the input video size.
    NS_E_INTERLACE_REQUIRE_SAMESIZE = HResultCode.new('NS_E_INTERLACE_REQUIRE_SAMESIZE', 0xc00d1b95, 'When you choose to maintain the interlacing in your video, the output video size must match the input video size.')

    # (0xc00d1b96) Only one device control plug-in can control a device.
    NS_E_TOO_MANY_DEVICECONTROL = HResultCode.new('NS_E_TOO_MANY_DEVICECONTROL', 0xc00d1b96, 'Only one device control plug-in can control a device.')

    # (0xc00d1b97) You must also enable storing content to hard disk temporarily in order to use two-pass encoding with the input device.
    NS_E_NO_MULTIPASS_FOR_LIVEDEVICE = HResultCode.new('NS_E_NO_MULTIPASS_FOR_LIVEDEVICE', 0xc00d1b97, 'You must also enable storing content to hard disk temporarily in order to use two-pass encoding with the input device.')

    # (0xc00d1b98) An audience is missing from the output stream configuration.
    NS_E_MISSING_AUDIENCE = HResultCode.new('NS_E_MISSING_AUDIENCE', 0xc00d1b98, 'An audience is missing from the output stream configuration.')

    # (0xc00d1b99) All audiences in the output tree must have the same content type.
    NS_E_AUDIENCE_CONTENTTYPE_MISMATCH = HResultCode.new('NS_E_AUDIENCE_CONTENTTYPE_MISMATCH', 0xc00d1b99, 'All audiences in the output tree must have the same content type.')

    # (0xc00d1b9a) A source index is missing from the output stream configuration.
    NS_E_MISSING_SOURCE_INDEX = HResultCode.new('NS_E_MISSING_SOURCE_INDEX', 0xc00d1b9a, 'A source index is missing from the output stream configuration.')

    # (0xc00d1b9b) The same source index in different audiences should have the same number of languages.
    NS_E_NUM_LANGUAGE_MISMATCH = HResultCode.new('NS_E_NUM_LANGUAGE_MISMATCH', 0xc00d1b9b, 'The same source index in different audiences should have the same number of languages.')

    # (0xc00d1b9c) The same source index in different audiences should have the same languages.
    NS_E_LANGUAGE_MISMATCH = HResultCode.new('NS_E_LANGUAGE_MISMATCH', 0xc00d1b9c, 'The same source index in different audiences should have the same languages.')

    # (0xc00d1b9d) The same source index in different audiences should use the same VBR encoding mode.
    NS_E_VBRMODE_MISMATCH = HResultCode.new('NS_E_VBRMODE_MISMATCH', 0xc00d1b9d, 'The same source index in different audiences should use the same VBR encoding mode.')

    # (0xc00d1b9e) The bit rate index specified is not valid.
    NS_E_INVALID_INPUT_AUDIENCE_INDEX = HResultCode.new('NS_E_INVALID_INPUT_AUDIENCE_INDEX', 0xc00d1b9e, 'The bit rate index specified is not valid.')

    # (0xc00d1b9f) The specified language is not valid.
    NS_E_INVALID_INPUT_LANGUAGE = HResultCode.new('NS_E_INVALID_INPUT_LANGUAGE', 0xc00d1b9f, 'The specified language is not valid.')

    # (0xc00d1ba0) The specified source type is not valid.
    NS_E_INVALID_INPUT_STREAM = HResultCode.new('NS_E_INVALID_INPUT_STREAM', 0xc00d1ba0, 'The specified source type is not valid.')

    # (0xc00d1ba1) The source must be a mono channel .wav file.
    NS_E_EXPECT_MONO_WAV_INPUT = HResultCode.new('NS_E_EXPECT_MONO_WAV_INPUT', 0xc00d1ba1, 'The source must be a mono channel .wav file.')

    # (0xc00d1ba2) All the source .wav files must have the same format.
    NS_E_INPUT_WAVFORMAT_MISMATCH = HResultCode.new('NS_E_INPUT_WAVFORMAT_MISMATCH', 0xc00d1ba2, 'All the source .wav files must have the same format.')

    # (0xc00d1ba3) The hard disk being used for temporary storage of content has reached the minimum allowed disk space. Create more space on the hard disk and restart encoding.
    NS_E_RECORDQ_DISK_FULL = HResultCode.new('NS_E_RECORDQ_DISK_FULL', 0xc00d1ba3, 'The hard disk being used for temporary storage of content has reached the minimum allowed disk space. Create more space on the hard disk and restart encoding.')

    # (0xc00d1ba4) It is not possible to apply the inverse telecine feature to PAL content.
    NS_E_NO_PAL_INVERSE_TELECINE = HResultCode.new('NS_E_NO_PAL_INVERSE_TELECINE', 0xc00d1ba4, 'It is not possible to apply the inverse telecine feature to PAL content.')

    # (0xc00d1ba5) A capture device in the current active source is no longer available.
    NS_E_ACTIVE_SG_DEVICE_DISCONNECTED = HResultCode.new('NS_E_ACTIVE_SG_DEVICE_DISCONNECTED', 0xc00d1ba5, 'A capture device in the current active source is no longer available.')

    # (0xc00d1ba6) A device used in the current active source for device control is no longer available.
    NS_E_ACTIVE_SG_DEVICE_CONTROL_DISCONNECTED = HResultCode.new('NS_E_ACTIVE_SG_DEVICE_CONTROL_DISCONNECTED', 0xc00d1ba6, 'A device used in the current active source for device control is no longer available.')

    # (0xc00d1ba7) No frames have been submitted to the analyzer for analysis.
    NS_E_NO_FRAMES_SUBMITTED_TO_ANALYZER = HResultCode.new('NS_E_NO_FRAMES_SUBMITTED_TO_ANALYZER', 0xc00d1ba7, 'No frames have been submitted to the analyzer for analysis.')

    # (0xc00d1ba8) The source video does not support time codes.
    NS_E_INPUT_DOESNOT_SUPPORT_SMPTE = HResultCode.new('NS_E_INPUT_DOESNOT_SUPPORT_SMPTE', 0xc00d1ba8, 'The source video does not support time codes.')

    # (0xc00d1ba9) It is not possible to generate a time code when there are multiple sources in a session.
    NS_E_NO_SMPTE_WITH_MULTIPLE_SOURCEGROUPS = HResultCode.new('NS_E_NO_SMPTE_WITH_MULTIPLE_SOURCEGROUPS', 0xc00d1ba9, 'It is not possible to generate a time code when there are multiple sources in a session.')

    # (0xc00d1baa) The voice codec optimization definition file cannot be found or is corrupted.
    NS_E_BAD_CONTENTEDL = HResultCode.new('NS_E_BAD_CONTENTEDL', 0xc00d1baa, 'The voice codec optimization definition file cannot be found or is corrupted.')

    # (0xc00d1bab) The same source index in different audiences should have the same interlace mode.
    NS_E_INTERLACEMODE_MISMATCH = HResultCode.new('NS_E_INTERLACEMODE_MISMATCH', 0xc00d1bab, 'The same source index in different audiences should have the same interlace mode.')

    # (0xc00d1bac) The same source index in different audiences should have the same nonsquare pixel mode.
    NS_E_NONSQUAREPIXELMODE_MISMATCH = HResultCode.new('NS_E_NONSQUAREPIXELMODE_MISMATCH', 0xc00d1bac, 'The same source index in different audiences should have the same nonsquare pixel mode.')

    # (0xc00d1bad) The same source index in different audiences should have the same time code mode.
    NS_E_SMPTEMODE_MISMATCH = HResultCode.new('NS_E_SMPTEMODE_MISMATCH', 0xc00d1bad, 'The same source index in different audiences should have the same time code mode.')

    # (0xc00d1bae) Either the end of the tape has been reached or there is no tape. Check the device and tape.
    NS_E_END_OF_TAPE = HResultCode.new('NS_E_END_OF_TAPE', 0xc00d1bae, 'Either the end of the tape has been reached or there is no tape. Check the device and tape.')

    # (0xc00d1baf) No audio or video input has been specified.
    NS_E_NO_MEDIA_IN_AUDIENCE = HResultCode.new('NS_E_NO_MEDIA_IN_AUDIENCE', 0xc00d1baf, 'No audio or video input has been specified.')

    # (0xc00d1bb0) The profile must contain a bit rate.
    NS_E_NO_AUDIENCES = HResultCode.new('NS_E_NO_AUDIENCES', 0xc00d1bb0, 'The profile must contain a bit rate.')

    # (0xc00d1bb1) You must specify at least one audio stream to be compatible with Windows Media Player 7.1.
    NS_E_NO_AUDIO_COMPAT = HResultCode.new('NS_E_NO_AUDIO_COMPAT', 0xc00d1bb1, 'You must specify at least one audio stream to be compatible with Windows Media Player 7.1.')

    # (0xc00d1bb2) Using a VBR encoding mode is not compatible with Windows Media Player 7.1.
    NS_E_INVALID_VBR_COMPAT = HResultCode.new('NS_E_INVALID_VBR_COMPAT', 0xc00d1bb2, 'Using a VBR encoding mode is not compatible with Windows Media Player 7.1.')

    # (0xc00d1bb3) You must specify a profile name.
    NS_E_NO_PROFILE_NAME = HResultCode.new('NS_E_NO_PROFILE_NAME', 0xc00d1bb3, 'You must specify a profile name.')

    # (0xc00d1bb4) It is not possible to use a VBR encoding mode with uncompressed audio or video.
    NS_E_INVALID_VBR_WITH_UNCOMP = HResultCode.new('NS_E_INVALID_VBR_WITH_UNCOMP', 0xc00d1bb4, 'It is not possible to use a VBR encoding mode with uncompressed audio or video.')

    # (0xc00d1bb5) It is not possible to use MBR encoding with VBR encoding.
    NS_E_MULTIPLE_VBR_AUDIENCES = HResultCode.new('NS_E_MULTIPLE_VBR_AUDIENCES', 0xc00d1bb5, 'It is not possible to use MBR encoding with VBR encoding.')

    # (0xc00d1bb6) It is not possible to mix uncompressed and compressed content in a session.
    NS_E_UNCOMP_COMP_COMBINATION = HResultCode.new('NS_E_UNCOMP_COMP_COMBINATION', 0xc00d1bb6, 'It is not possible to mix uncompressed and compressed content in a session.')

    # (0xc00d1bb7) All audiences must use the same audio codec.
    NS_E_MULTIPLE_AUDIO_CODECS = HResultCode.new('NS_E_MULTIPLE_AUDIO_CODECS', 0xc00d1bb7, 'All audiences must use the same audio codec.')

    # (0xc00d1bb8) All audiences should use the same audio format to be compatible with Windows Media Player 7.1.
    NS_E_MULTIPLE_AUDIO_FORMATS = HResultCode.new('NS_E_MULTIPLE_AUDIO_FORMATS', 0xc00d1bb8, 'All audiences should use the same audio format to be compatible with Windows Media Player 7.1.')

    # (0xc00d1bb9) The audio bit rate for an audience with a higher total bit rate must be greater than one with a lower total bit rate.
    NS_E_AUDIO_BITRATE_STEPDOWN = HResultCode.new('NS_E_AUDIO_BITRATE_STEPDOWN', 0xc00d1bb9, 'The audio bit rate for an audience with a higher total bit rate must be greater than one with a lower total bit rate.')

    # (0xc00d1bba) The audio peak bit rate setting is not valid.
    NS_E_INVALID_AUDIO_PEAKRATE = HResultCode.new('NS_E_INVALID_AUDIO_PEAKRATE', 0xc00d1bba, 'The audio peak bit rate setting is not valid.')

    # (0xc00d1bbb) The audio peak bit rate setting must be greater than the audio bit rate setting.
    NS_E_INVALID_AUDIO_PEAKRATE_2 = HResultCode.new('NS_E_INVALID_AUDIO_PEAKRATE_2', 0xc00d1bbb, 'The audio peak bit rate setting must be greater than the audio bit rate setting.')

    # (0xc00d1bbc) The setting for the maximum buffer size for audio is not valid.
    NS_E_INVALID_AUDIO_BUFFERMAX = HResultCode.new('NS_E_INVALID_AUDIO_BUFFERMAX', 0xc00d1bbc, 'The setting for the maximum buffer size for audio is not valid.')

    # (0xc00d1bbd) All audiences must use the same video codec.
    NS_E_MULTIPLE_VIDEO_CODECS = HResultCode.new('NS_E_MULTIPLE_VIDEO_CODECS', 0xc00d1bbd, 'All audiences must use the same video codec.')

    # (0xc00d1bbe) All audiences should use the same video size to be compatible with Windows Media Player 7.1.
    NS_E_MULTIPLE_VIDEO_SIZES = HResultCode.new('NS_E_MULTIPLE_VIDEO_SIZES', 0xc00d1bbe, 'All audiences should use the same video size to be compatible with Windows Media Player 7.1.')

    # (0xc00d1bbf) The video bit rate setting is not valid.
    NS_E_INVALID_VIDEO_BITRATE = HResultCode.new('NS_E_INVALID_VIDEO_BITRATE', 0xc00d1bbf, 'The video bit rate setting is not valid.')

    # (0xc00d1bc0) The video bit rate for an audience with a higher total bit rate must be greater than one with a lower total bit rate.
    NS_E_VIDEO_BITRATE_STEPDOWN = HResultCode.new('NS_E_VIDEO_BITRATE_STEPDOWN', 0xc00d1bc0, 'The video bit rate for an audience with a higher total bit rate must be greater than one with a lower total bit rate.')

    # (0xc00d1bc1) The video peak bit rate setting is not valid.
    NS_E_INVALID_VIDEO_PEAKRATE = HResultCode.new('NS_E_INVALID_VIDEO_PEAKRATE', 0xc00d1bc1, 'The video peak bit rate setting is not valid.')

    # (0xc00d1bc2) The video peak bit rate setting must be greater than the video bit rate setting.
    NS_E_INVALID_VIDEO_PEAKRATE_2 = HResultCode.new('NS_E_INVALID_VIDEO_PEAKRATE_2', 0xc00d1bc2, 'The video peak bit rate setting must be greater than the video bit rate setting.')

    # (0xc00d1bc3) The video width setting is not valid.
    NS_E_INVALID_VIDEO_WIDTH = HResultCode.new('NS_E_INVALID_VIDEO_WIDTH', 0xc00d1bc3, 'The video width setting is not valid.')

    # (0xc00d1bc4) The video height setting is not valid.
    NS_E_INVALID_VIDEO_HEIGHT = HResultCode.new('NS_E_INVALID_VIDEO_HEIGHT', 0xc00d1bc4, 'The video height setting is not valid.')

    # (0xc00d1bc5) The video frame rate setting is not valid.
    NS_E_INVALID_VIDEO_FPS = HResultCode.new('NS_E_INVALID_VIDEO_FPS', 0xc00d1bc5, 'The video frame rate setting is not valid.')

    # (0xc00d1bc6) The video key frame setting is not valid.
    NS_E_INVALID_VIDEO_KEYFRAME = HResultCode.new('NS_E_INVALID_VIDEO_KEYFRAME', 0xc00d1bc6, 'The video key frame setting is not valid.')

    # (0xc00d1bc7) The video image quality setting is not valid.
    NS_E_INVALID_VIDEO_IQUALITY = HResultCode.new('NS_E_INVALID_VIDEO_IQUALITY', 0xc00d1bc7, 'The video image quality setting is not valid.')

    # (0xc00d1bc8) The video codec quality setting is not valid.
    NS_E_INVALID_VIDEO_CQUALITY = HResultCode.new('NS_E_INVALID_VIDEO_CQUALITY', 0xc00d1bc8, 'The video codec quality setting is not valid.')

    # (0xc00d1bc9) The video buffer setting is not valid.
    NS_E_INVALID_VIDEO_BUFFER = HResultCode.new('NS_E_INVALID_VIDEO_BUFFER', 0xc00d1bc9, 'The video buffer setting is not valid.')

    # (0xc00d1bca) The setting for the maximum buffer size for video is not valid.
    NS_E_INVALID_VIDEO_BUFFERMAX = HResultCode.new('NS_E_INVALID_VIDEO_BUFFERMAX', 0xc00d1bca, 'The setting for the maximum buffer size for video is not valid.')

    # (0xc00d1bcb) The value of the video maximum buffer size setting must be greater than the video buffer size setting.
    NS_E_INVALID_VIDEO_BUFFERMAX_2 = HResultCode.new('NS_E_INVALID_VIDEO_BUFFERMAX_2', 0xc00d1bcb, 'The value of the video maximum buffer size setting must be greater than the video buffer size setting.')

    # (0xc00d1bcc) The alignment of the video width is not valid.
    NS_E_INVALID_VIDEO_WIDTH_ALIGN = HResultCode.new('NS_E_INVALID_VIDEO_WIDTH_ALIGN', 0xc00d1bcc, 'The alignment of the video width is not valid.')

    # (0xc00d1bcd) The alignment of the video height is not valid.
    NS_E_INVALID_VIDEO_HEIGHT_ALIGN = HResultCode.new('NS_E_INVALID_VIDEO_HEIGHT_ALIGN', 0xc00d1bcd, 'The alignment of the video height is not valid.')

    # (0xc00d1bce) All bit rates must have the same script bit rate.
    NS_E_MULTIPLE_SCRIPT_BITRATES = HResultCode.new('NS_E_MULTIPLE_SCRIPT_BITRATES', 0xc00d1bce, 'All bit rates must have the same script bit rate.')

    # (0xc00d1bcf) The script bit rate specified is not valid.
    NS_E_INVALID_SCRIPT_BITRATE = HResultCode.new('NS_E_INVALID_SCRIPT_BITRATE', 0xc00d1bcf, 'The script bit rate specified is not valid.')

    # (0xc00d1bd0) All bit rates must have the same file transfer bit rate.
    NS_E_MULTIPLE_FILE_BITRATES = HResultCode.new('NS_E_MULTIPLE_FILE_BITRATES', 0xc00d1bd0, 'All bit rates must have the same file transfer bit rate.')

    # (0xc00d1bd1) The file transfer bit rate is not valid.
    NS_E_INVALID_FILE_BITRATE = HResultCode.new('NS_E_INVALID_FILE_BITRATE', 0xc00d1bd1, 'The file transfer bit rate is not valid.')

    # (0xc00d1bd2) All audiences in a profile should either be same as input or have video width and height specified.
    NS_E_SAME_AS_INPUT_COMBINATION = HResultCode.new('NS_E_SAME_AS_INPUT_COMBINATION', 0xc00d1bd2, 'All audiences in a profile should either be same as input or have video width and height specified.')

    # (0xc00d1bd3) This source type does not support looping.
    NS_E_SOURCE_CANNOT_LOOP = HResultCode.new('NS_E_SOURCE_CANNOT_LOOP', 0xc00d1bd3, 'This source type does not support looping.')

    # (0xc00d1bd4) The fold-down value needs to be between -144 and 0.
    NS_E_INVALID_FOLDDOWN_COEFFICIENTS = HResultCode.new('NS_E_INVALID_FOLDDOWN_COEFFICIENTS', 0xc00d1bd4, 'The fold-down value needs to be between -144 and 0.')

    # (0xc00d1bd5) The specified DRM profile does not exist in the system.
    NS_E_DRMPROFILE_NOTFOUND = HResultCode.new('NS_E_DRMPROFILE_NOTFOUND', 0xc00d1bd5, 'The specified DRM profile does not exist in the system.')

    # (0xc00d1bd6) The specified time code is not valid.
    NS_E_INVALID_TIMECODE = HResultCode.new('NS_E_INVALID_TIMECODE', 0xc00d1bd6, 'The specified time code is not valid.')

    # (0xc00d1bd7) It is not possible to apply time compression to a video-only session.
    NS_E_NO_AUDIO_TIMECOMPRESSION = HResultCode.new('NS_E_NO_AUDIO_TIMECOMPRESSION', 0xc00d1bd7, 'It is not possible to apply time compression to a video-only session.')

    # (0xc00d1bd8) It is not possible to apply time compression to a session that is using two-pass encoding.
    NS_E_NO_TWOPASS_TIMECOMPRESSION = HResultCode.new('NS_E_NO_TWOPASS_TIMECOMPRESSION', 0xc00d1bd8, 'It is not possible to apply time compression to a session that is using two-pass encoding.')

    # (0xc00d1bd9) It is not possible to generate a time code for an audio-only session.
    NS_E_TIMECODE_REQUIRES_VIDEOSTREAM = HResultCode.new('NS_E_TIMECODE_REQUIRES_VIDEOSTREAM', 0xc00d1bd9, 'It is not possible to generate a time code for an audio-only session.')

    # (0xc00d1bda) It is not possible to generate a time code when you are encoding content at multiple bit rates.
    NS_E_NO_MBR_WITH_TIMECODE = HResultCode.new('NS_E_NO_MBR_WITH_TIMECODE', 0xc00d1bda, 'It is not possible to generate a time code when you are encoding content at multiple bit rates.')

    # (0xc00d1bdb) The video codec selected does not support maintaining interlacing in video.
    NS_E_INVALID_INTERLACEMODE = HResultCode.new('NS_E_INVALID_INTERLACEMODE', 0xc00d1bdb, 'The video codec selected does not support maintaining interlacing in video.')

    # (0xc00d1bdc) Maintaining interlacing in video is not compatible with Windows Media Player 7.1.
    NS_E_INVALID_INTERLACE_COMPAT = HResultCode.new('NS_E_INVALID_INTERLACE_COMPAT', 0xc00d1bdc, 'Maintaining interlacing in video is not compatible with Windows Media Player 7.1.')

    # (0xc00d1bdd) Allowing nonsquare pixel output is not compatible with Windows Media Player 7.1.
    NS_E_INVALID_NONSQUAREPIXEL_COMPAT = HResultCode.new('NS_E_INVALID_NONSQUAREPIXEL_COMPAT', 0xc00d1bdd, 'Allowing nonsquare pixel output is not compatible with Windows Media Player 7.1.')

    # (0xc00d1bde) Only capture devices can be used with device control.
    NS_E_INVALID_SOURCE_WITH_DEVICE_CONTROL = HResultCode.new('NS_E_INVALID_SOURCE_WITH_DEVICE_CONTROL', 0xc00d1bde, 'Only capture devices can be used with device control.')

    # (0xc00d1bdf) It is not possible to generate the stream format file if you are using quality-based VBR encoding for the audio or video stream. Instead use the Windows Media file generated after encoding to create the announcement file.
    NS_E_CANNOT_GENERATE_BROADCAST_INFO_FOR_QUALITYVBR = HResultCode.new('NS_E_CANNOT_GENERATE_BROADCAST_INFO_FOR_QUALITYVBR', 0xc00d1bdf, 'It is not possible to generate the stream format file if you are using quality-based VBR encoding for the audio or video stream. Instead use the Windows Media file generated after encoding to create the announcement file.')

    # (0xc00d1be0) It is not possible to create a DRM profile because the maximum number of profiles has been reached. You must delete some DRM profiles before creating new ones.
    NS_E_EXCEED_MAX_DRM_PROFILE_LIMIT = HResultCode.new('NS_E_EXCEED_MAX_DRM_PROFILE_LIMIT', 0xc00d1be0, 'It is not possible to create a DRM profile because the maximum number of profiles has been reached. You must delete some DRM profiles before creating new ones.')

    # (0xc00d1be1) The device is in an unstable state. Check that the device is functioning properly and a tape is in place.
    NS_E_DEVICECONTROL_UNSTABLE = HResultCode.new('NS_E_DEVICECONTROL_UNSTABLE', 0xc00d1be1, 'The device is in an unstable state. Check that the device is functioning properly and a tape is in place.')

    # (0xc00d1be2) The pixel aspect ratio value must be between 1 and 255.
    NS_E_INVALID_PIXEL_ASPECT_RATIO = HResultCode.new('NS_E_INVALID_PIXEL_ASPECT_RATIO', 0xc00d1be2, 'The pixel aspect ratio value must be between 1 and 255.')

    # (0xc00d1be3) All streams with different languages in the same audience must have same properties.
    NS_E_AUDIENCE__LANGUAGE_CONTENTTYPE_MISMATCH = HResultCode.new('NS_E_AUDIENCE__LANGUAGE_CONTENTTYPE_MISMATCH', 0xc00d1be3, 'All streams with different languages in the same audience must have same properties.')

    # (0xc00d1be4) The profile must contain at least one audio or video stream.
    NS_E_INVALID_PROFILE_CONTENTTYPE = HResultCode.new('NS_E_INVALID_PROFILE_CONTENTTYPE', 0xc00d1be4, 'The profile must contain at least one audio or video stream.')

    # (0xc00d1be5) The transform plug-in could not be found.
    NS_E_TRANSFORM_PLUGIN_NOT_FOUND = HResultCode.new('NS_E_TRANSFORM_PLUGIN_NOT_FOUND', 0xc00d1be5, 'The transform plug-in could not be found.')

    # (0xc00d1be6) The transform plug-in is not valid. It might be damaged or you might not have the required permissions to access the plug-in.
    NS_E_TRANSFORM_PLUGIN_INVALID = HResultCode.new('NS_E_TRANSFORM_PLUGIN_INVALID', 0xc00d1be6, 'The transform plug-in is not valid. It might be damaged or you might not have the required permissions to access the plug-in.')

    # (0xc00d1be7) To use two-pass encoding, you must enable device control and setup an edit decision list (EDL) that has at least one entry.
    NS_E_EDL_REQUIRED_FOR_DEVICE_MULTIPASS = HResultCode.new('NS_E_EDL_REQUIRED_FOR_DEVICE_MULTIPASS', 0xc00d1be7, 'To use two-pass encoding, you must enable device control and setup an edit decision list (EDL) that has at least one entry.')

    # (0xc00d1be8) When you choose to maintain the interlacing in your video, the output video size must be a multiple of 4.
    NS_E_INVALID_VIDEO_WIDTH_FOR_INTERLACED_ENCODING = HResultCode.new('NS_E_INVALID_VIDEO_WIDTH_FOR_INTERLACED_ENCODING', 0xc00d1be8, 'When you choose to maintain the interlacing in your video, the output video size must be a multiple of 4.')

    # (0xc00d1be9) Markin/Markout is unsupported with this source type.
    NS_E_MARKIN_UNSUPPORTED = HResultCode.new('NS_E_MARKIN_UNSUPPORTED', 0xc00d1be9, 'Markin/Markout is unsupported with this source type.')

    # (0xc00d2711) A problem has occurred in the Digital Rights Management component. Contact product support for this application.
    NS_E_DRM_INVALID_APPLICATION = HResultCode.new('NS_E_DRM_INVALID_APPLICATION', 0xc00d2711, 'A problem has occurred in the Digital Rights Management component. Contact product support for this application.')

    # (0xc00d2712) License storage is not working. Contact Microsoft product support.
    NS_E_DRM_LICENSE_STORE_ERROR = HResultCode.new('NS_E_DRM_LICENSE_STORE_ERROR', 0xc00d2712, 'License storage is not working. Contact Microsoft product support.')

    # (0xc00d2713) Secure storage is not working. Contact Microsoft product support.
    NS_E_DRM_SECURE_STORE_ERROR = HResultCode.new('NS_E_DRM_SECURE_STORE_ERROR', 0xc00d2713, 'Secure storage is not working. Contact Microsoft product support.')

    # (0xc00d2714) License acquisition did not work. Acquire a new license or contact the content provider for further assistance.
    NS_E_DRM_LICENSE_STORE_SAVE_ERROR = HResultCode.new('NS_E_DRM_LICENSE_STORE_SAVE_ERROR', 0xc00d2714, 'License acquisition did not work. Acquire a new license or contact the content provider for further assistance.')

    # (0xc00d2715) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_SECURE_STORE_UNLOCK_ERROR = HResultCode.new('NS_E_DRM_SECURE_STORE_UNLOCK_ERROR', 0xc00d2715, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2716) The media file is corrupted. Contact the content provider to get a new file.
    NS_E_DRM_INVALID_CONTENT = HResultCode.new('NS_E_DRM_INVALID_CONTENT', 0xc00d2716, 'The media file is corrupted. Contact the content provider to get a new file.')

    # (0xc00d2717) The license is corrupted. Acquire a new license.
    NS_E_DRM_UNABLE_TO_OPEN_LICENSE = HResultCode.new('NS_E_DRM_UNABLE_TO_OPEN_LICENSE', 0xc00d2717, 'The license is corrupted. Acquire a new license.')

    # (0xc00d2718) The license is corrupted or invalid. Acquire a new license
    NS_E_DRM_INVALID_LICENSE = HResultCode.new('NS_E_DRM_INVALID_LICENSE', 0xc00d2718, 'The license is corrupted or invalid. Acquire a new license')

    # (0xc00d2719) Licenses cannot be copied from one computer to another. Use License Management to transfer licenses, or get a new license for the media file.
    NS_E_DRM_INVALID_MACHINE = HResultCode.new('NS_E_DRM_INVALID_MACHINE', 0xc00d2719, 'Licenses cannot be copied from one computer to another. Use License Management to transfer licenses, or get a new license for the media file.')

    # (0xc00d271b) License storage is not working. Contact Microsoft product support.
    NS_E_DRM_ENUM_LICENSE_FAILED = HResultCode.new('NS_E_DRM_ENUM_LICENSE_FAILED', 0xc00d271b, 'License storage is not working. Contact Microsoft product support.')

    # (0xc00d271c) The media file is corrupted. Contact the content provider to get a new file.
    NS_E_DRM_INVALID_LICENSE_REQUEST = HResultCode.new('NS_E_DRM_INVALID_LICENSE_REQUEST', 0xc00d271c, 'The media file is corrupted. Contact the content provider to get a new file.')

    # (0xc00d271d) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_INITIALIZE = HResultCode.new('NS_E_DRM_UNABLE_TO_INITIALIZE', 0xc00d271d, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d271e) The license could not be acquired. Try again later.
    NS_E_DRM_UNABLE_TO_ACQUIRE_LICENSE = HResultCode.new('NS_E_DRM_UNABLE_TO_ACQUIRE_LICENSE', 0xc00d271e, 'The license could not be acquired. Try again later.')

    # (0xc00d271f) License acquisition did not work. Acquire a new license or contact the content provider for further assistance.
    NS_E_DRM_INVALID_LICENSE_ACQUIRED = HResultCode.new('NS_E_DRM_INVALID_LICENSE_ACQUIRED', 0xc00d271f, 'License acquisition did not work. Acquire a new license or contact the content provider for further assistance.')

    # (0xc00d2720) The requested operation cannot be performed on this file.
    NS_E_DRM_NO_RIGHTS = HResultCode.new('NS_E_DRM_NO_RIGHTS', 0xc00d2720, 'The requested operation cannot be performed on this file.')

    # (0xc00d2721) The requested action cannot be performed because a problem occurred with the Windows Media Digital Rights Management (DRM) components on your computer.
    NS_E_DRM_KEY_ERROR = HResultCode.new('NS_E_DRM_KEY_ERROR', 0xc00d2721, 'The requested action cannot be performed because a problem occurred with the Windows Media Digital Rights Management (DRM) components on your computer.')

    # (0xc00d2722) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_ENCRYPT_ERROR = HResultCode.new('NS_E_DRM_ENCRYPT_ERROR', 0xc00d2722, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2723) The media file is corrupted. Contact the content provider to get a new file.
    NS_E_DRM_DECRYPT_ERROR = HResultCode.new('NS_E_DRM_DECRYPT_ERROR', 0xc00d2723, 'The media file is corrupted. Contact the content provider to get a new file.')

    # (0xc00d2725) The license is corrupted. Acquire a new license.
    NS_E_DRM_LICENSE_INVALID_XML = HResultCode.new('NS_E_DRM_LICENSE_INVALID_XML', 0xc00d2725, 'The license is corrupted. Acquire a new license.')

    # (0xc00d2728) A security upgrade is required to perform the operation on this media file.
    NS_E_DRM_NEEDS_INDIVIDUALIZATION = HResultCode.new('NS_E_DRM_NEEDS_INDIVIDUALIZATION', 0xc00d2728, 'A security upgrade is required to perform the operation on this media file.')

    # (0xc00d2729) You already have the latest security components. No upgrade is necessary at this time.
    NS_E_DRM_ALREADY_INDIVIDUALIZED = HResultCode.new('NS_E_DRM_ALREADY_INDIVIDUALIZED', 0xc00d2729, 'You already have the latest security components. No upgrade is necessary at this time.')

    # (0xc00d272a) The application cannot perform this action. Contact product support for this application.
    NS_E_DRM_ACTION_NOT_QUERIED = HResultCode.new('NS_E_DRM_ACTION_NOT_QUERIED', 0xc00d272a, 'The application cannot perform this action. Contact product support for this application.')

    # (0xc00d272b) You cannot begin a new license acquisition process until the current one has been completed.
    NS_E_DRM_ACQUIRING_LICENSE = HResultCode.new('NS_E_DRM_ACQUIRING_LICENSE', 0xc00d272b, 'You cannot begin a new license acquisition process until the current one has been completed.')

    # (0xc00d272c) You cannot begin a new security upgrade until the current one has been completed.
    NS_E_DRM_INDIVIDUALIZING = HResultCode.new('NS_E_DRM_INDIVIDUALIZING', 0xc00d272c, 'You cannot begin a new security upgrade until the current one has been completed.')

    # (0xc00d272d) Failure in Backup-Restore.
    NS_E_BACKUP_RESTORE_FAILURE = HResultCode.new('NS_E_BACKUP_RESTORE_FAILURE', 0xc00d272d, 'Failure in Backup-Restore.')

    # (0xc00d272e) Bad Request ID in Backup-Restore.
    NS_E_BACKUP_RESTORE_BAD_REQUEST_ID = HResultCode.new('NS_E_BACKUP_RESTORE_BAD_REQUEST_ID', 0xc00d272e, 'Bad Request ID in Backup-Restore.')

    # (0xc00d272f) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_PARAMETERS_MISMATCHED = HResultCode.new('NS_E_DRM_PARAMETERS_MISMATCHED', 0xc00d272f, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2730) A license cannot be created for this media file. Reinstall the application.
    NS_E_DRM_UNABLE_TO_CREATE_LICENSE_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_LICENSE_OBJECT', 0xc00d2730, 'A license cannot be created for this media file. Reinstall the application.')

    # (0xc00d2731) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_INDI_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_INDI_OBJECT', 0xc00d2731, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2732) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_ENCRYPT_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_ENCRYPT_OBJECT', 0xc00d2732, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2733) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_DECRYPT_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_DECRYPT_OBJECT', 0xc00d2733, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2734) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_PROPERTIES_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_PROPERTIES_OBJECT', 0xc00d2734, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2735) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_BACKUP_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_BACKUP_OBJECT', 0xc00d2735, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2736) The security upgrade failed. Try again later.
    NS_E_DRM_INDIVIDUALIZE_ERROR = HResultCode.new('NS_E_DRM_INDIVIDUALIZE_ERROR', 0xc00d2736, 'The security upgrade failed. Try again later.')

    # (0xc00d2737) License storage is not working. Contact Microsoft product support.
    NS_E_DRM_LICENSE_OPEN_ERROR = HResultCode.new('NS_E_DRM_LICENSE_OPEN_ERROR', 0xc00d2737, 'License storage is not working. Contact Microsoft product support.')

    # (0xc00d2738) License storage is not working. Contact Microsoft product support.
    NS_E_DRM_LICENSE_CLOSE_ERROR = HResultCode.new('NS_E_DRM_LICENSE_CLOSE_ERROR', 0xc00d2738, 'License storage is not working. Contact Microsoft product support.')

    # (0xc00d2739) License storage is not working. Contact Microsoft product support.
    NS_E_DRM_GET_LICENSE_ERROR = HResultCode.new('NS_E_DRM_GET_LICENSE_ERROR', 0xc00d2739, 'License storage is not working. Contact Microsoft product support.')

    # (0xc00d273a) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_QUERY_ERROR = HResultCode.new('NS_E_DRM_QUERY_ERROR', 0xc00d273a, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d273b) A problem has occurred in the Digital Rights Management component. Contact product support for this application.
    NS_E_DRM_REPORT_ERROR = HResultCode.new('NS_E_DRM_REPORT_ERROR', 0xc00d273b, 'A problem has occurred in the Digital Rights Management component. Contact product support for this application.')

    # (0xc00d273c) License storage is not working. Contact Microsoft product support.
    NS_E_DRM_GET_LICENSESTRING_ERROR = HResultCode.new('NS_E_DRM_GET_LICENSESTRING_ERROR', 0xc00d273c, 'License storage is not working. Contact Microsoft product support.')

    # (0xc00d273d) The media file is corrupted. Contact the content provider to get a new file.
    NS_E_DRM_GET_CONTENTSTRING_ERROR = HResultCode.new('NS_E_DRM_GET_CONTENTSTRING_ERROR', 0xc00d273d, 'The media file is corrupted. Contact the content provider to get a new file.')

    # (0xc00d273e) A problem has occurred in the Digital Rights Management component. Try again later.
    NS_E_DRM_MONITOR_ERROR = HResultCode.new('NS_E_DRM_MONITOR_ERROR', 0xc00d273e, 'A problem has occurred in the Digital Rights Management component. Try again later.')

    # (0xc00d273f) The application has made an invalid call to the Digital Rights Management component. Contact product support for this application.
    NS_E_DRM_UNABLE_TO_SET_PARAMETER = HResultCode.new('NS_E_DRM_UNABLE_TO_SET_PARAMETER', 0xc00d273f, 'The application has made an invalid call to the Digital Rights Management component. Contact product support for this application.')

    # (0xc00d2740) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_INVALID_APPDATA = HResultCode.new('NS_E_DRM_INVALID_APPDATA', 0xc00d2740, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2741) A problem has occurred in the Digital Rights Management component. Contact product support for this application.
    NS_E_DRM_INVALID_APPDATA_VERSION = HResultCode.new('NS_E_DRM_INVALID_APPDATA_VERSION', 0xc00d2741, 'A problem has occurred in the Digital Rights Management component. Contact product support for this application.')

    # (0xc00d2742) Licenses are already backed up in this location.
    NS_E_DRM_BACKUP_EXISTS = HResultCode.new('NS_E_DRM_BACKUP_EXISTS', 0xc00d2742, 'Licenses are already backed up in this location.')

    # (0xc00d2743) One or more backed-up licenses are missing or corrupt.
    NS_E_DRM_BACKUP_CORRUPT = HResultCode.new('NS_E_DRM_BACKUP_CORRUPT', 0xc00d2743, 'One or more backed-up licenses are missing or corrupt.')

    # (0xc00d2744) You cannot begin a new backup process until the current process has been completed.
    NS_E_DRM_BACKUPRESTORE_BUSY = HResultCode.new('NS_E_DRM_BACKUPRESTORE_BUSY', 0xc00d2744, 'You cannot begin a new backup process until the current process has been completed.')

    # (0xc00d2745) Bad Data sent to Backup-Restore.
    NS_E_BACKUP_RESTORE_BAD_DATA = HResultCode.new('NS_E_BACKUP_RESTORE_BAD_DATA', 0xc00d2745, 'Bad Data sent to Backup-Restore.')

    # (0xc00d2748) The license is invalid. Contact the content provider for further assistance.
    NS_E_DRM_LICENSE_UNUSABLE = HResultCode.new('NS_E_DRM_LICENSE_UNUSABLE', 0xc00d2748, 'The license is invalid. Contact the content provider for further assistance.')

    # (0xc00d2749) A required property was not set by the application. Contact product support for this application.
    NS_E_DRM_INVALID_PROPERTY = HResultCode.new('NS_E_DRM_INVALID_PROPERTY', 0xc00d2749, 'A required property was not set by the application. Contact product support for this application.')

    # (0xc00d274a) A problem has occurred in the Digital Rights Management component of this application. Try to acquire a license again.
    NS_E_DRM_SECURE_STORE_NOT_FOUND = HResultCode.new('NS_E_DRM_SECURE_STORE_NOT_FOUND', 0xc00d274a, 'A problem has occurred in the Digital Rights Management component of this application. Try to acquire a license again.')

    # (0xc00d274b) A license cannot be found for this media file. Use License Management to transfer a license for this file from the original computer, or acquire a new license.
    NS_E_DRM_CACHED_CONTENT_ERROR = HResultCode.new('NS_E_DRM_CACHED_CONTENT_ERROR', 0xc00d274b, 'A license cannot be found for this media file. Use License Management to transfer a license for this file from the original computer, or acquire a new license.')

    # (0xc00d274c) A problem occurred during the security upgrade. Try again later.
    NS_E_DRM_INDIVIDUALIZATION_INCOMPLETE = HResultCode.new('NS_E_DRM_INDIVIDUALIZATION_INCOMPLETE', 0xc00d274c, 'A problem occurred during the security upgrade. Try again later.')

    # (0xc00d274d) Certified driver components are required to play this media file. Contact Windows Update to see whether updated drivers are available for your hardware.
    NS_E_DRM_DRIVER_AUTH_FAILURE = HResultCode.new('NS_E_DRM_DRIVER_AUTH_FAILURE', 0xc00d274d, 'Certified driver components are required to play this media file. Contact Windows Update to see whether updated drivers are available for your hardware.')

    # (0xc00d274e) One or more of the Secure Audio Path components were not found or an entry point in those components was not found.
    NS_E_DRM_NEED_UPGRADE_MSSAP = HResultCode.new('NS_E_DRM_NEED_UPGRADE_MSSAP', 0xc00d274e, 'One or more of the Secure Audio Path components were not found or an entry point in those components was not found.')

    # (0xc00d274f) Status message: Reopen the file.
    NS_E_DRM_REOPEN_CONTENT = HResultCode.new('NS_E_DRM_REOPEN_CONTENT', 0xc00d274f, 'Status message: Reopen the file.')

    # (0xc00d2750) Certain driver functionality is required to play this media file. Contact Windows Update to see whether updated drivers are available for your hardware.
    NS_E_DRM_DRIVER_DIGIOUT_FAILURE = HResultCode.new('NS_E_DRM_DRIVER_DIGIOUT_FAILURE', 0xc00d2750, 'Certain driver functionality is required to play this media file. Contact Windows Update to see whether updated drivers are available for your hardware.')

    # (0xc00d2751) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_INVALID_SECURESTORE_PASSWORD = HResultCode.new('NS_E_DRM_INVALID_SECURESTORE_PASSWORD', 0xc00d2751, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2752) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_APPCERT_REVOKED = HResultCode.new('NS_E_DRM_APPCERT_REVOKED', 0xc00d2752, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2753) You cannot restore your license(s).
    NS_E_DRM_RESTORE_FRAUD = HResultCode.new('NS_E_DRM_RESTORE_FRAUD', 0xc00d2753, 'You cannot restore your license(s).')

    # (0xc00d2754) The licenses for your media files are corrupted. Contact Microsoft product support.
    NS_E_DRM_HARDWARE_INCONSISTENT = HResultCode.new('NS_E_DRM_HARDWARE_INCONSISTENT', 0xc00d2754, 'The licenses for your media files are corrupted. Contact Microsoft product support.')

    # (0xc00d2755) To transfer this media file, you must upgrade the application.
    NS_E_DRM_SDMI_TRIGGER = HResultCode.new('NS_E_DRM_SDMI_TRIGGER', 0xc00d2755, 'To transfer this media file, you must upgrade the application.')

    # (0xc00d2756) You cannot make any more copies of this media file.
    NS_E_DRM_SDMI_NOMORECOPIES = HResultCode.new('NS_E_DRM_SDMI_NOMORECOPIES', 0xc00d2756, 'You cannot make any more copies of this media file.')

    # (0xc00d2757) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_HEADER_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_HEADER_OBJECT', 0xc00d2757, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2758) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_KEYS_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_KEYS_OBJECT', 0xc00d2758, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2759) Unable to obtain license.
    NS_E_DRM_LICENSE_NOTACQUIRED = HResultCode.new('NS_E_DRM_LICENSE_NOTACQUIRED', 0xc00d2759, 'Unable to obtain license.')

    # (0xc00d275a) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_CODING_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_CODING_OBJECT', 0xc00d275a, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d275b) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_STATE_DATA_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_STATE_DATA_OBJECT', 0xc00d275b, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d275c) The buffer supplied is not sufficient.
    NS_E_DRM_BUFFER_TOO_SMALL = HResultCode.new('NS_E_DRM_BUFFER_TOO_SMALL', 0xc00d275c, 'The buffer supplied is not sufficient.')

    # (0xc00d275d) The property requested is not supported.
    NS_E_DRM_UNSUPPORTED_PROPERTY = HResultCode.new('NS_E_DRM_UNSUPPORTED_PROPERTY', 0xc00d275d, 'The property requested is not supported.')

    # (0xc00d275e) The specified server cannot perform the requested operation.
    NS_E_DRM_ERROR_BAD_NET_RESP = HResultCode.new('NS_E_DRM_ERROR_BAD_NET_RESP', 0xc00d275e, 'The specified server cannot perform the requested operation.')

    # (0xc00d275f) Some of the licenses could not be stored.
    NS_E_DRM_STORE_NOTALLSTORED = HResultCode.new('NS_E_DRM_STORE_NOTALLSTORED', 0xc00d275f, 'Some of the licenses could not be stored.')

    # (0xc00d2760) The Digital Rights Management security upgrade component could not be validated. Contact Microsoft product support.
    NS_E_DRM_SECURITY_COMPONENT_SIGNATURE_INVALID = HResultCode.new('NS_E_DRM_SECURITY_COMPONENT_SIGNATURE_INVALID', 0xc00d2760, 'The Digital Rights Management security upgrade component could not be validated. Contact Microsoft product support.')

    # (0xc00d2761) Invalid or corrupt data was encountered.
    NS_E_DRM_INVALID_DATA = HResultCode.new('NS_E_DRM_INVALID_DATA', 0xc00d2761, 'Invalid or corrupt data was encountered.')

    # (0xc00d2762) The Windows Media Digital Rights Management system cannot perform the requested action because your computer or network administrator has enabled the group policy Prevent Windows Media DRM Internet Access. For assistance, contact your administrator.
    NS_E_DRM_POLICY_DISABLE_ONLINE = HResultCode.new('NS_E_DRM_POLICY_DISABLE_ONLINE', 0xc00d2762, 'The Windows Media Digital Rights Management system cannot perform the requested action because your computer or network administrator has enabled the group policy Prevent Windows Media DRM Internet Access. For assistance, contact your administrator.')

    # (0xc00d2763) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_AUTHENTICATION_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_AUTHENTICATION_OBJECT', 0xc00d2763, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2764) Not all of the necessary properties for DRM have been set.
    NS_E_DRM_NOT_CONFIGURED = HResultCode.new('NS_E_DRM_NOT_CONFIGURED', 0xc00d2764, 'Not all of the necessary properties for DRM have been set.')

    # (0xc00d2765) The portable device does not have the security required to copy protected files to it. To obtain the additional security, try to copy the file to your portable device again. When a message appears, click OK.
    NS_E_DRM_DEVICE_ACTIVATION_CANCELED = HResultCode.new('NS_E_DRM_DEVICE_ACTIVATION_CANCELED', 0xc00d2765, 'The portable device does not have the security required to copy protected files to it. To obtain the additional security, try to copy the file to your portable device again. When a message appears, click OK.')

    # (0xc00d2766) Too many resets in Backup-Restore.
    NS_E_BACKUP_RESTORE_TOO_MANY_RESETS = HResultCode.new('NS_E_BACKUP_RESTORE_TOO_MANY_RESETS', 0xc00d2766, 'Too many resets in Backup-Restore.')

    # (0xc00d2767) Running this process under a debugger while using DRM content is not allowed.
    NS_E_DRM_DEBUGGING_NOT_ALLOWED = HResultCode.new('NS_E_DRM_DEBUGGING_NOT_ALLOWED', 0xc00d2767, 'Running this process under a debugger while using DRM content is not allowed.')

    # (0xc00d2768) The user canceled the DRM operation.
    NS_E_DRM_OPERATION_CANCELED = HResultCode.new('NS_E_DRM_OPERATION_CANCELED', 0xc00d2768, 'The user canceled the DRM operation.')

    # (0xc00d2769) The license you are using has assocaited output restrictions. This license is unusable until these restrictions are queried.
    NS_E_DRM_RESTRICTIONS_NOT_RETRIEVED = HResultCode.new('NS_E_DRM_RESTRICTIONS_NOT_RETRIEVED', 0xc00d2769, 'The license you are using has assocaited output restrictions. This license is unusable until these restrictions are queried.')

    # (0xc00d276a) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_PLAYLIST_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_PLAYLIST_OBJECT', 0xc00d276a, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d276b) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_PLAYLIST_BURN_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_PLAYLIST_BURN_OBJECT', 0xc00d276b, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d276c) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_DEVICE_REGISTRATION_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_DEVICE_REGISTRATION_OBJECT', 0xc00d276c, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d276d) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_METERING_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_METERING_OBJECT', 0xc00d276d, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2770) The specified track has exceeded it's specified playlist burn limit in this playlist.
    NS_E_DRM_TRACK_EXCEEDED_PLAYLIST_RESTICTION = HResultCode.new('NS_E_DRM_TRACK_EXCEEDED_PLAYLIST_RESTICTION', 0xc00d2770, 'The specified track has exceeded it\'s specified playlist burn limit in this playlist.')

    # (0xc00d2771) The specified track has exceeded it's track burn limit.
    NS_E_DRM_TRACK_EXCEEDED_TRACKBURN_RESTRICTION = HResultCode.new('NS_E_DRM_TRACK_EXCEEDED_TRACKBURN_RESTRICTION', 0xc00d2771, 'The specified track has exceeded it\'s track burn limit.')

    # (0xc00d2772) A problem has occurred in obtaining the device's certificate. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_GET_DEVICE_CERT = HResultCode.new('NS_E_DRM_UNABLE_TO_GET_DEVICE_CERT', 0xc00d2772, 'A problem has occurred in obtaining the device\'s certificate. Contact Microsoft product support.')

    # (0xc00d2773) A problem has occurred in obtaining the device's secure clock. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_GET_SECURE_CLOCK = HResultCode.new('NS_E_DRM_UNABLE_TO_GET_SECURE_CLOCK', 0xc00d2773, 'A problem has occurred in obtaining the device\'s secure clock. Contact Microsoft product support.')

    # (0xc00d2774) A problem has occurred in setting the device's secure clock. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_SET_SECURE_CLOCK = HResultCode.new('NS_E_DRM_UNABLE_TO_SET_SECURE_CLOCK', 0xc00d2774, 'A problem has occurred in setting the device\'s secure clock. Contact Microsoft product support.')

    # (0xc00d2775) A problem has occurred in obtaining the secure clock from server. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_GET_SECURE_CLOCK_FROM_SERVER = HResultCode.new('NS_E_DRM_UNABLE_TO_GET_SECURE_CLOCK_FROM_SERVER', 0xc00d2775, 'A problem has occurred in obtaining the secure clock from server. Contact Microsoft product support.')

    # (0xc00d2776) This content requires the metering policy to be enabled.
    NS_E_DRM_POLICY_METERING_DISABLED = HResultCode.new('NS_E_DRM_POLICY_METERING_DISABLED', 0xc00d2776, 'This content requires the metering policy to be enabled.')

    # (0xc00d2777) Transfer of chained licenses unsupported.
    NS_E_DRM_TRANSFER_CHAINED_LICENSES_UNSUPPORTED = HResultCode.new('NS_E_DRM_TRANSFER_CHAINED_LICENSES_UNSUPPORTED', 0xc00d2777, 'Transfer of chained licenses unsupported.')

    # (0xc00d2778) The Digital Rights Management component is not installed properly. Reinstall the Player.
    NS_E_DRM_SDK_VERSIONMISMATCH = HResultCode.new('NS_E_DRM_SDK_VERSIONMISMATCH', 0xc00d2778, 'The Digital Rights Management component is not installed properly. Reinstall the Player.')

    # (0xc00d2779) The file could not be transferred because the device clock is not set.
    NS_E_DRM_LIC_NEEDS_DEVICE_CLOCK_SET = HResultCode.new('NS_E_DRM_LIC_NEEDS_DEVICE_CLOCK_SET', 0xc00d2779, 'The file could not be transferred because the device clock is not set.')

    # (0xc00d277a) The content header is missing an acquisition URL.
    NS_E_LICENSE_HEADER_MISSING_URL = HResultCode.new('NS_E_LICENSE_HEADER_MISSING_URL', 0xc00d277a, 'The content header is missing an acquisition URL.')

    # (0xc00d277b) The current attached device does not support WMDRM.
    NS_E_DEVICE_NOT_WMDRM_DEVICE = HResultCode.new('NS_E_DEVICE_NOT_WMDRM_DEVICE', 0xc00d277b, 'The current attached device does not support WMDRM.')

    # (0xc00d277c) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_INVALID_APPCERT = HResultCode.new('NS_E_DRM_INVALID_APPCERT', 0xc00d277c, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d277d) The client application has been forcefully terminated during a DRM petition.
    NS_E_DRM_PROTOCOL_FORCEFUL_TERMINATION_ON_PETITION = HResultCode.new('NS_E_DRM_PROTOCOL_FORCEFUL_TERMINATION_ON_PETITION', 0xc00d277d, 'The client application has been forcefully terminated during a DRM petition.')

    # (0xc00d277e) The client application has been forcefully terminated during a DRM challenge.
    NS_E_DRM_PROTOCOL_FORCEFUL_TERMINATION_ON_CHALLENGE = HResultCode.new('NS_E_DRM_PROTOCOL_FORCEFUL_TERMINATION_ON_CHALLENGE', 0xc00d277e, 'The client application has been forcefully terminated during a DRM challenge.')

    # (0xc00d277f) Secure storage protection error. Restore your licenses from a previous backup and try again.
    NS_E_DRM_CHECKPOINT_FAILED = HResultCode.new('NS_E_DRM_CHECKPOINT_FAILED', 0xc00d277f, 'Secure storage protection error. Restore your licenses from a previous backup and try again.')

    # (0xc00d2780) A problem has occurred in the Digital Rights Management root of trust. Contact Microsoft product support.
    NS_E_DRM_BB_UNABLE_TO_INITIALIZE = HResultCode.new('NS_E_DRM_BB_UNABLE_TO_INITIALIZE', 0xc00d2780, 'A problem has occurred in the Digital Rights Management root of trust. Contact Microsoft product support.')

    # (0xc00d2781) A problem has occurred in retrieving the Digital Rights Management machine identification. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_LOAD_HARDWARE_ID = HResultCode.new('NS_E_DRM_UNABLE_TO_LOAD_HARDWARE_ID', 0xc00d2781, 'A problem has occurred in retrieving the Digital Rights Management machine identification. Contact Microsoft product support.')

    # (0xc00d2782) A problem has occurred in opening the Digital Rights Management data storage file. Contact Microsoft product.
    NS_E_DRM_UNABLE_TO_OPEN_DATA_STORE = HResultCode.new('NS_E_DRM_UNABLE_TO_OPEN_DATA_STORE', 0xc00d2782, 'A problem has occurred in opening the Digital Rights Management data storage file. Contact Microsoft product.')

    # (0xc00d2783) The Digital Rights Management data storage is not functioning properly. Contact Microsoft product support.
    NS_E_DRM_DATASTORE_CORRUPT = HResultCode.new('NS_E_DRM_DATASTORE_CORRUPT', 0xc00d2783, 'The Digital Rights Management data storage is not functioning properly. Contact Microsoft product support.')

    # (0xc00d2784) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_INMEMORYSTORE_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_INMEMORYSTORE_OBJECT', 0xc00d2784, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2785) A secured library is required to access the requested functionality.
    NS_E_DRM_STUBLIB_REQUIRED = HResultCode.new('NS_E_DRM_STUBLIB_REQUIRED', 0xc00d2785, 'A secured library is required to access the requested functionality.')

    # (0xc00d2786) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_UNABLE_TO_CREATE_CERTIFICATE_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_CERTIFICATE_OBJECT', 0xc00d2786, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2787) A problem has occurred in the Digital Rights Management component during license migration. Contact Microsoft product support.
    NS_E_DRM_MIGRATION_TARGET_NOT_ONLINE = HResultCode.new('NS_E_DRM_MIGRATION_TARGET_NOT_ONLINE', 0xc00d2787, 'A problem has occurred in the Digital Rights Management component during license migration. Contact Microsoft product support.')

    # (0xc00d2788) A problem has occurred in the Digital Rights Management component during license migration. Contact Microsoft product support.
    NS_E_DRM_INVALID_MIGRATION_IMAGE = HResultCode.new('NS_E_DRM_INVALID_MIGRATION_IMAGE', 0xc00d2788, 'A problem has occurred in the Digital Rights Management component during license migration. Contact Microsoft product support.')

    # (0xc00d2789) A problem has occurred in the Digital Rights Management component during license migration. Contact Microsoft product support.
    NS_E_DRM_MIGRATION_TARGET_STATES_CORRUPTED = HResultCode.new('NS_E_DRM_MIGRATION_TARGET_STATES_CORRUPTED', 0xc00d2789, 'A problem has occurred in the Digital Rights Management component during license migration. Contact Microsoft product support.')

    # (0xc00d278a) A problem has occurred in the Digital Rights Management component during license migration. Contact Microsoft product support.
    NS_E_DRM_MIGRATION_IMPORTER_NOT_AVAILABLE = HResultCode.new('NS_E_DRM_MIGRATION_IMPORTER_NOT_AVAILABLE', 0xc00d278a, 'A problem has occurred in the Digital Rights Management component during license migration. Contact Microsoft product support.')

    # (0xc00d278b) A problem has occurred in the Digital Rights Management component during license migration. Contact Microsoft product support.
    NS_DRM_E_MIGRATION_UPGRADE_WITH_DIFF_SID = HResultCode.new('NS_DRM_E_MIGRATION_UPGRADE_WITH_DIFF_SID', 0xc00d278b, 'A problem has occurred in the Digital Rights Management component during license migration. Contact Microsoft product support.')

    # (0xc00d278c) The Digital Rights Management component is in use during license migration. Contact Microsoft product support.
    NS_DRM_E_MIGRATION_SOURCE_MACHINE_IN_USE = HResultCode.new('NS_DRM_E_MIGRATION_SOURCE_MACHINE_IN_USE', 0xc00d278c, 'The Digital Rights Management component is in use during license migration. Contact Microsoft product support.')

    # (0xc00d278d) Licenses are being migrated to a machine running XP or downlevel OS. This operation can only be performed on Windows Vista or a later OS. Contact Microsoft product support.
    NS_DRM_E_MIGRATION_TARGET_MACHINE_LESS_THAN_LH = HResultCode.new('NS_DRM_E_MIGRATION_TARGET_MACHINE_LESS_THAN_LH', 0xc00d278d, 'Licenses are being migrated to a machine running XP or downlevel OS. This operation can only be performed on Windows Vista or a later OS. Contact Microsoft product support.')

    # (0xc00d278e) Migration Image already exists. Contact Microsoft product support.
    NS_DRM_E_MIGRATION_IMAGE_ALREADY_EXISTS = HResultCode.new('NS_DRM_E_MIGRATION_IMAGE_ALREADY_EXISTS', 0xc00d278e, 'Migration Image already exists. Contact Microsoft product support.')

    # (0xc00d278f) The requested action cannot be performed because a hardware configuration change has been detected by the Windows Media Digital Rights Management (DRM) components on your computer.
    NS_E_DRM_HARDWAREID_MISMATCH = HResultCode.new('NS_E_DRM_HARDWAREID_MISMATCH', 0xc00d278f, 'The requested action cannot be performed because a hardware configuration change has been detected by the Windows Media Digital Rights Management (DRM) components on your computer.')

    # (0xc00d2790) The wrong stublib has been linked to an application or DLL using drmv2clt.dll.
    NS_E_INVALID_DRMV2CLT_STUBLIB = HResultCode.new('NS_E_INVALID_DRMV2CLT_STUBLIB', 0xc00d2790, 'The wrong stublib has been linked to an application or DLL using drmv2clt.dll.')

    # (0xc00d2791) The legacy V2 data being imported is invalid.
    NS_E_DRM_MIGRATION_INVALID_LEGACYV2_DATA = HResultCode.new('NS_E_DRM_MIGRATION_INVALID_LEGACYV2_DATA', 0xc00d2791, 'The legacy V2 data being imported is invalid.')

    # (0xc00d2792) The license being imported already exists.
    NS_E_DRM_MIGRATION_LICENSE_ALREADY_EXISTS = HResultCode.new('NS_E_DRM_MIGRATION_LICENSE_ALREADY_EXISTS', 0xc00d2792, 'The license being imported already exists.')

    # (0xc00d2793) The password of the Legacy V2 SST entry being imported is incorrect.
    NS_E_DRM_MIGRATION_INVALID_LEGACYV2_SST_PASSWORD = HResultCode.new('NS_E_DRM_MIGRATION_INVALID_LEGACYV2_SST_PASSWORD', 0xc00d2793, 'The password of the Legacy V2 SST entry being imported is incorrect.')

    # (0xc00d2794) Migration is not supported by the plugin.
    NS_E_DRM_MIGRATION_NOT_SUPPORTED = HResultCode.new('NS_E_DRM_MIGRATION_NOT_SUPPORTED', 0xc00d2794, 'Migration is not supported by the plugin.')

    # (0xc00d2795) A migration importer cannot be created for this media file. Reinstall the application.
    NS_E_DRM_UNABLE_TO_CREATE_MIGRATION_IMPORTER_OBJECT = HResultCode.new('NS_E_DRM_UNABLE_TO_CREATE_MIGRATION_IMPORTER_OBJECT', 0xc00d2795, 'A migration importer cannot be created for this media file. Reinstall the application.')

    # (0xc00d2796) The requested action cannot be performed because a problem occurred with the Windows Media Digital Rights Management (DRM) components on your computer.
    NS_E_DRM_CHECKPOINT_MISMATCH = HResultCode.new('NS_E_DRM_CHECKPOINT_MISMATCH', 0xc00d2796, 'The requested action cannot be performed because a problem occurred with the Windows Media Digital Rights Management (DRM) components on your computer.')

    # (0xc00d2797) The requested action cannot be performed because a problem occurred with the Windows Media Digital Rights Management (DRM) components on your computer.
    NS_E_DRM_CHECKPOINT_CORRUPT = HResultCode.new('NS_E_DRM_CHECKPOINT_CORRUPT', 0xc00d2797, 'The requested action cannot be performed because a problem occurred with the Windows Media Digital Rights Management (DRM) components on your computer.')

    # (0xc00d2798) The requested action cannot be performed because a problem occurred with the Windows Media Digital Rights Management (DRM) components on your computer.
    NS_E_REG_FLUSH_FAILURE = HResultCode.new('NS_E_REG_FLUSH_FAILURE', 0xc00d2798, 'The requested action cannot be performed because a problem occurred with the Windows Media Digital Rights Management (DRM) components on your computer.')

    # (0xc00d2799) The requested action cannot be performed because a problem occurred with the Windows Media Digital Rights Management (DRM) components on your computer.
    NS_E_HDS_KEY_MISMATCH = HResultCode.new('NS_E_HDS_KEY_MISMATCH', 0xc00d2799, 'The requested action cannot be performed because a problem occurred with the Windows Media Digital Rights Management (DRM) components on your computer.')

    # (0xc00d279a) Migration was canceled by the user.
    NS_E_DRM_MIGRATION_OPERATION_CANCELLED = HResultCode.new('NS_E_DRM_MIGRATION_OPERATION_CANCELLED', 0xc00d279a, 'Migration was canceled by the user.')

    # (0xc00d279b) Migration object is already in use and cannot be called until the current operation completes.
    NS_E_DRM_MIGRATION_OBJECT_IN_USE = HResultCode.new('NS_E_DRM_MIGRATION_OBJECT_IN_USE', 0xc00d279b, 'Migration object is already in use and cannot be called until the current operation completes.')

    # (0xc00d279c) The content header does not comply with DRM requirements and cannot be used.
    NS_E_DRM_MALFORMED_CONTENT_HEADER = HResultCode.new('NS_E_DRM_MALFORMED_CONTENT_HEADER', 0xc00d279c, 'The content header does not comply with DRM requirements and cannot be used.')

    # (0xc00d27d8) The license for this file has expired and is no longer valid. Contact your content provider for further assistance.
    NS_E_DRM_LICENSE_EXPIRED = HResultCode.new('NS_E_DRM_LICENSE_EXPIRED', 0xc00d27d8, 'The license for this file has expired and is no longer valid. Contact your content provider for further assistance.')

    # (0xc00d27d9) The license for this file is not valid yet, but will be at a future date.
    NS_E_DRM_LICENSE_NOTENABLED = HResultCode.new('NS_E_DRM_LICENSE_NOTENABLED', 0xc00d27d9, 'The license for this file is not valid yet, but will be at a future date.')

    # (0xc00d27da) The license for this file requires a higher level of security than the player you are currently using has. Try using a different player or download a newer version of your current player.
    NS_E_DRM_LICENSE_APPSECLOW = HResultCode.new('NS_E_DRM_LICENSE_APPSECLOW', 0xc00d27da, 'The license for this file requires a higher level of security than the player you are currently using has. Try using a different player or download a newer version of your current player.')

    # (0xc00d27db) The license cannot be stored as it requires security upgrade of Digital Rights Management component.
    NS_E_DRM_STORE_NEEDINDI = HResultCode.new('NS_E_DRM_STORE_NEEDINDI', 0xc00d27db, 'The license cannot be stored as it requires security upgrade of Digital Rights Management component.')

    # (0xc00d27dc) Your machine does not meet the requirements for storing the license.
    NS_E_DRM_STORE_NOTALLOWED = HResultCode.new('NS_E_DRM_STORE_NOTALLOWED', 0xc00d27dc, 'Your machine does not meet the requirements for storing the license.')

    # (0xc00d27dd) The license for this file requires an upgraded version of your player or a different player.
    NS_E_DRM_LICENSE_APP_NOTALLOWED = HResultCode.new('NS_E_DRM_LICENSE_APP_NOTALLOWED', 0xc00d27dd, 'The license for this file requires an upgraded version of your player or a different player.')

    # (0xc00d27df) The license server's certificate expired. Make sure your system clock is set correctly. Contact your content provider for further assistance.
    NS_E_DRM_LICENSE_CERT_EXPIRED = HResultCode.new('NS_E_DRM_LICENSE_CERT_EXPIRED', 0xc00d27df, 'The license server\'s certificate expired. Make sure your system clock is set correctly. Contact your content provider for further assistance.')

    # (0xc00d27e0) The license for this file requires a higher level of security than the player you are currently using has. Try using a different player or download a newer version of your current player.
    NS_E_DRM_LICENSE_SECLOW = HResultCode.new('NS_E_DRM_LICENSE_SECLOW', 0xc00d27e0, 'The license for this file requires a higher level of security than the player you are currently using has. Try using a different player or download a newer version of your current player.')

    # (0xc00d27e1) The content owner for the license you just acquired is no longer supporting their content. Contact the content owner for a newer version of the content.
    NS_E_DRM_LICENSE_CONTENT_REVOKED = HResultCode.new('NS_E_DRM_LICENSE_CONTENT_REVOKED', 0xc00d27e1, 'The content owner for the license you just acquired is no longer supporting their content. Contact the content owner for a newer version of the content.')

    # (0xc00d27e2) The content owner for the license you just acquired requires your device to register to the current machine.
    NS_E_DRM_DEVICE_NOT_REGISTERED = HResultCode.new('NS_E_DRM_DEVICE_NOT_REGISTERED', 0xc00d27e2, 'The content owner for the license you just acquired requires your device to register to the current machine.')

    # (0xc00d280a) The license for this file requires a feature that is not supported in your current player or operating system. You can try with newer version of your current player or contact your content provider for further assistance.
    NS_E_DRM_LICENSE_NOSAP = HResultCode.new('NS_E_DRM_LICENSE_NOSAP', 0xc00d280a, 'The license for this file requires a feature that is not supported in your current player or operating system. You can try with newer version of your current player or contact your content provider for further assistance.')

    # (0xc00d280b) The license for this file requires a feature that is not supported in your current player or operating system. You can try with newer version of your current player or contact your content provider for further assistance.
    NS_E_DRM_LICENSE_NOSVP = HResultCode.new('NS_E_DRM_LICENSE_NOSVP', 0xc00d280b, 'The license for this file requires a feature that is not supported in your current player or operating system. You can try with newer version of your current player or contact your content provider for further assistance.')

    # (0xc00d280c) The license for this file requires Windows Driver Model (WDM) audio drivers. Contact your sound card manufacturer for further assistance.
    NS_E_DRM_LICENSE_NOWDM = HResultCode.new('NS_E_DRM_LICENSE_NOWDM', 0xc00d280c, 'The license for this file requires Windows Driver Model (WDM) audio drivers. Contact your sound card manufacturer for further assistance.')

    # (0xc00d280d) The license for this file requires a higher level of security than the player you are currently using has. Try using a different player or download a newer version of your current player.
    NS_E_DRM_LICENSE_NOTRUSTEDCODEC = HResultCode.new('NS_E_DRM_LICENSE_NOTRUSTEDCODEC', 0xc00d280d, 'The license for this file requires a higher level of security than the player you are currently using has. Try using a different player or download a newer version of your current player.')

    # (0xc00d280e) The license for this file is not supported by your current player. You can try with newer version of your current player or contact your content provider for further assistance.
    NS_E_DRM_SOURCEID_NOT_SUPPORTED = HResultCode.new('NS_E_DRM_SOURCEID_NOT_SUPPORTED', 0xc00d280e, 'The license for this file is not supported by your current player. You can try with newer version of your current player or contact your content provider for further assistance.')

    # (0xc00d283d) An updated version of your media player is required to play the selected content.
    NS_E_DRM_NEEDS_UPGRADE_TEMPFILE = HResultCode.new('NS_E_DRM_NEEDS_UPGRADE_TEMPFILE', 0xc00d283d, 'An updated version of your media player is required to play the selected content.')

    # (0xc00d283e) A new version of the Digital Rights Management component is required. Contact product support for this application to get the latest version.
    NS_E_DRM_NEED_UPGRADE_PD = HResultCode.new('NS_E_DRM_NEED_UPGRADE_PD', 0xc00d283e, 'A new version of the Digital Rights Management component is required. Contact product support for this application to get the latest version.')

    # (0xc00d283f) Failed to either create or verify the content header.
    NS_E_DRM_SIGNATURE_FAILURE = HResultCode.new('NS_E_DRM_SIGNATURE_FAILURE', 0xc00d283f, 'Failed to either create or verify the content header.')

    # (0xc00d2840) Could not read the necessary information from the system registry.
    NS_E_DRM_LICENSE_SERVER_INFO_MISSING = HResultCode.new('NS_E_DRM_LICENSE_SERVER_INFO_MISSING', 0xc00d2840, 'Could not read the necessary information from the system registry.')

    # (0xc00d2841) The DRM subsystem is currently locked by another application or user. Try again later.
    NS_E_DRM_BUSY = HResultCode.new('NS_E_DRM_BUSY', 0xc00d2841, 'The DRM subsystem is currently locked by another application or user. Try again later.')

    # (0xc00d2842) There are too many target devices registered on the portable media.
    NS_E_DRM_PD_TOO_MANY_DEVICES = HResultCode.new('NS_E_DRM_PD_TOO_MANY_DEVICES', 0xc00d2842, 'There are too many target devices registered on the portable media.')

    # (0xc00d2843) The security upgrade cannot be completed because the allowed number of daily upgrades has been exceeded. Try again tomorrow.
    NS_E_DRM_INDIV_FRAUD = HResultCode.new('NS_E_DRM_INDIV_FRAUD', 0xc00d2843, 'The security upgrade cannot be completed because the allowed number of daily upgrades has been exceeded. Try again tomorrow.')

    # (0xc00d2844) The security upgrade cannot be completed because the server is unable to perform the operation. Try again later.
    NS_E_DRM_INDIV_NO_CABS = HResultCode.new('NS_E_DRM_INDIV_NO_CABS', 0xc00d2844, 'The security upgrade cannot be completed because the server is unable to perform the operation. Try again later.')

    # (0xc00d2845) The security upgrade cannot be performed because the server is not available. Try again later.
    NS_E_DRM_INDIV_SERVICE_UNAVAILABLE = HResultCode.new('NS_E_DRM_INDIV_SERVICE_UNAVAILABLE', 0xc00d2845, 'The security upgrade cannot be performed because the server is not available. Try again later.')

    # (0xc00d2846) Windows Media Player cannot restore your licenses because the server is not available. Try again later.
    NS_E_DRM_RESTORE_SERVICE_UNAVAILABLE = HResultCode.new('NS_E_DRM_RESTORE_SERVICE_UNAVAILABLE', 0xc00d2846, 'Windows Media Player cannot restore your licenses because the server is not available. Try again later.')

    # (0xc00d2847) Windows Media Player cannot play the protected file. Verify that your computer's date is set correctly. If it is correct, on the Help menu, click Check for Player Updates to install the latest version of the Player.
    NS_E_DRM_CLIENT_CODE_EXPIRED = HResultCode.new('NS_E_DRM_CLIENT_CODE_EXPIRED', 0xc00d2847, 'Windows Media Player cannot play the protected file. Verify that your computer\'s date is set correctly. If it is correct, on the Help menu, click Check for Player Updates to install the latest version of the Player.')

    # (0xc00d2848) The chained license cannot be created because the referenced uplink license does not exist.
    NS_E_DRM_NO_UPLINK_LICENSE = HResultCode.new('NS_E_DRM_NO_UPLINK_LICENSE', 0xc00d2848, 'The chained license cannot be created because the referenced uplink license does not exist.')

    # (0xc00d2849) The specified KID is invalid.
    NS_E_DRM_INVALID_KID = HResultCode.new('NS_E_DRM_INVALID_KID', 0xc00d2849, 'The specified KID is invalid.')

    # (0xc00d284a) License initialization did not work. Contact Microsoft product support.
    NS_E_DRM_LICENSE_INITIALIZATION_ERROR = HResultCode.new('NS_E_DRM_LICENSE_INITIALIZATION_ERROR', 0xc00d284a, 'License initialization did not work. Contact Microsoft product support.')

    # (0xc00d284c) The uplink license of a chained license cannot itself be a chained license.
    NS_E_DRM_CHAIN_TOO_LONG = HResultCode.new('NS_E_DRM_CHAIN_TOO_LONG', 0xc00d284c, 'The uplink license of a chained license cannot itself be a chained license.')

    # (0xc00d284d) The specified encryption algorithm is unsupported.
    NS_E_DRM_UNSUPPORTED_ALGORITHM = HResultCode.new('NS_E_DRM_UNSUPPORTED_ALGORITHM', 0xc00d284d, 'The specified encryption algorithm is unsupported.')

    # (0xc00d284e) License deletion did not work. Contact Microsoft product support.
    NS_E_DRM_LICENSE_DELETION_ERROR = HResultCode.new('NS_E_DRM_LICENSE_DELETION_ERROR', 0xc00d284e, 'License deletion did not work. Contact Microsoft product support.')

    # (0xc00d28a0) The client's certificate is corrupted or the signature cannot be verified.
    NS_E_DRM_INVALID_CERTIFICATE = HResultCode.new('NS_E_DRM_INVALID_CERTIFICATE', 0xc00d28a0, 'The client\'s certificate is corrupted or the signature cannot be verified.')

    # (0xc00d28a1) The client's certificate has been revoked.
    NS_E_DRM_CERTIFICATE_REVOKED = HResultCode.new('NS_E_DRM_CERTIFICATE_REVOKED', 0xc00d28a1, 'The client\'s certificate has been revoked.')

    # (0xc00d28a2) There is no license available for the requested action.
    NS_E_DRM_LICENSE_UNAVAILABLE = HResultCode.new('NS_E_DRM_LICENSE_UNAVAILABLE', 0xc00d28a2, 'There is no license available for the requested action.')

    # (0xc00d28a3) The maximum number of devices in use has been reached. Unable to open additional devices.
    NS_E_DRM_DEVICE_LIMIT_REACHED = HResultCode.new('NS_E_DRM_DEVICE_LIMIT_REACHED', 0xc00d28a3, 'The maximum number of devices in use has been reached. Unable to open additional devices.')

    # (0xc00d28a4) The proximity detection procedure could not confirm that the receiver is near the transmitter in the network.
    NS_E_DRM_UNABLE_TO_VERIFY_PROXIMITY = HResultCode.new('NS_E_DRM_UNABLE_TO_VERIFY_PROXIMITY', 0xc00d28a4, 'The proximity detection procedure could not confirm that the receiver is near the transmitter in the network.')

    # (0xc00d28a5) The client must be registered before executing the intended operation.
    NS_E_DRM_MUST_REGISTER = HResultCode.new('NS_E_DRM_MUST_REGISTER', 0xc00d28a5, 'The client must be registered before executing the intended operation.')

    # (0xc00d28a6) The client must be approved before executing the intended operation.
    NS_E_DRM_MUST_APPROVE = HResultCode.new('NS_E_DRM_MUST_APPROVE', 0xc00d28a6, 'The client must be approved before executing the intended operation.')

    # (0xc00d28a7) The client must be revalidated before executing the intended operation.
    NS_E_DRM_MUST_REVALIDATE = HResultCode.new('NS_E_DRM_MUST_REVALIDATE', 0xc00d28a7, 'The client must be revalidated before executing the intended operation.')

    # (0xc00d28a8) The response to the proximity detection challenge is invalid.
    NS_E_DRM_INVALID_PROXIMITY_RESPONSE = HResultCode.new('NS_E_DRM_INVALID_PROXIMITY_RESPONSE', 0xc00d28a8, 'The response to the proximity detection challenge is invalid.')

    # (0xc00d28a9) The requested session is invalid.
    NS_E_DRM_INVALID_SESSION = HResultCode.new('NS_E_DRM_INVALID_SESSION', 0xc00d28a9, 'The requested session is invalid.')

    # (0xc00d28aa) The device must be opened before it can be used to receive content.
    NS_E_DRM_DEVICE_NOT_OPEN = HResultCode.new('NS_E_DRM_DEVICE_NOT_OPEN', 0xc00d28aa, 'The device must be opened before it can be used to receive content.')

    # (0xc00d28ab) Device registration failed because the device is already registered.
    NS_E_DRM_DEVICE_ALREADY_REGISTERED = HResultCode.new('NS_E_DRM_DEVICE_ALREADY_REGISTERED', 0xc00d28ab, 'Device registration failed because the device is already registered.')

    # (0xc00d28ac) Unsupported WMDRM-ND protocol version.
    NS_E_DRM_UNSUPPORTED_PROTOCOL_VERSION = HResultCode.new('NS_E_DRM_UNSUPPORTED_PROTOCOL_VERSION', 0xc00d28ac, 'Unsupported WMDRM-ND protocol version.')

    # (0xc00d28ad) The requested action is not supported.
    NS_E_DRM_UNSUPPORTED_ACTION = HResultCode.new('NS_E_DRM_UNSUPPORTED_ACTION', 0xc00d28ad, 'The requested action is not supported.')

    # (0xc00d28ae) The certificate does not have an adequate security level for the requested action.
    NS_E_DRM_CERTIFICATE_SECURITY_LEVEL_INADEQUATE = HResultCode.new('NS_E_DRM_CERTIFICATE_SECURITY_LEVEL_INADEQUATE', 0xc00d28ae, 'The certificate does not have an adequate security level for the requested action.')

    # (0xc00d28af) Unable to open the specified port for receiving Proximity messages.
    NS_E_DRM_UNABLE_TO_OPEN_PORT = HResultCode.new('NS_E_DRM_UNABLE_TO_OPEN_PORT', 0xc00d28af, 'Unable to open the specified port for receiving Proximity messages.')

    # (0xc00d28b0) The message format is invalid.
    NS_E_DRM_BAD_REQUEST = HResultCode.new('NS_E_DRM_BAD_REQUEST', 0xc00d28b0, 'The message format is invalid.')

    # (0xc00d28b1) The Certificate Revocation List is invalid or corrupted.
    NS_E_DRM_INVALID_CRL = HResultCode.new('NS_E_DRM_INVALID_CRL', 0xc00d28b1, 'The Certificate Revocation List is invalid or corrupted.')

    # (0xc00d28b2) The length of the attribute name or value is too long.
    NS_E_DRM_ATTRIBUTE_TOO_LONG = HResultCode.new('NS_E_DRM_ATTRIBUTE_TOO_LONG', 0xc00d28b2, 'The length of the attribute name or value is too long.')

    # (0xc00d28b3) The license blob passed in the cardea request is expired.
    NS_E_DRM_EXPIRED_LICENSEBLOB = HResultCode.new('NS_E_DRM_EXPIRED_LICENSEBLOB', 0xc00d28b3, 'The license blob passed in the cardea request is expired.')

    # (0xc00d28b4) The license blob passed in the cardea request is invalid. Contact Microsoft product support.
    NS_E_DRM_INVALID_LICENSEBLOB = HResultCode.new('NS_E_DRM_INVALID_LICENSEBLOB', 0xc00d28b4, 'The license blob passed in the cardea request is invalid. Contact Microsoft product support.')

    # (0xc00d28b5) The requested operation cannot be performed because the license does not contain an inclusion list.
    NS_E_DRM_INCLUSION_LIST_REQUIRED = HResultCode.new('NS_E_DRM_INCLUSION_LIST_REQUIRED', 0xc00d28b5, 'The requested operation cannot be performed because the license does not contain an inclusion list.')

    # (0xc00d28b6) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_DRMV2CLT_REVOKED = HResultCode.new('NS_E_DRM_DRMV2CLT_REVOKED', 0xc00d28b6, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d28b7) A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.
    NS_E_DRM_RIV_TOO_SMALL = HResultCode.new('NS_E_DRM_RIV_TOO_SMALL', 0xc00d28b7, 'A problem has occurred in the Digital Rights Management component. Contact Microsoft product support.')

    # (0xc00d2904) Windows Media Player does not support the level of output protection required by the content.
    NS_E_OUTPUT_PROTECTION_LEVEL_UNSUPPORTED = HResultCode.new('NS_E_OUTPUT_PROTECTION_LEVEL_UNSUPPORTED', 0xc00d2904, 'Windows Media Player does not support the level of output protection required by the content.')

    # (0xc00d2905) Windows Media Player does not support the level of protection required for compressed digital video.
    NS_E_COMPRESSED_DIGITAL_VIDEO_PROTECTION_LEVEL_UNSUPPORTED = HResultCode.new('NS_E_COMPRESSED_DIGITAL_VIDEO_PROTECTION_LEVEL_UNSUPPORTED', 0xc00d2905, 'Windows Media Player does not support the level of protection required for compressed digital video.')

    # (0xc00d2906) Windows Media Player does not support the level of protection required for uncompressed digital video.
    NS_E_UNCOMPRESSED_DIGITAL_VIDEO_PROTECTION_LEVEL_UNSUPPORTED = HResultCode.new('NS_E_UNCOMPRESSED_DIGITAL_VIDEO_PROTECTION_LEVEL_UNSUPPORTED', 0xc00d2906, 'Windows Media Player does not support the level of protection required for uncompressed digital video.')

    # (0xc00d2907) Windows Media Player does not support the level of protection required for analog video.
    NS_E_ANALOG_VIDEO_PROTECTION_LEVEL_UNSUPPORTED = HResultCode.new('NS_E_ANALOG_VIDEO_PROTECTION_LEVEL_UNSUPPORTED', 0xc00d2907, 'Windows Media Player does not support the level of protection required for analog video.')

    # (0xc00d2908) Windows Media Player does not support the level of protection required for compressed digital audio.
    NS_E_COMPRESSED_DIGITAL_AUDIO_PROTECTION_LEVEL_UNSUPPORTED = HResultCode.new('NS_E_COMPRESSED_DIGITAL_AUDIO_PROTECTION_LEVEL_UNSUPPORTED', 0xc00d2908, 'Windows Media Player does not support the level of protection required for compressed digital audio.')

    # (0xc00d2909) Windows Media Player does not support the level of protection required for uncompressed digital audio.
    NS_E_UNCOMPRESSED_DIGITAL_AUDIO_PROTECTION_LEVEL_UNSUPPORTED = HResultCode.new('NS_E_UNCOMPRESSED_DIGITAL_AUDIO_PROTECTION_LEVEL_UNSUPPORTED', 0xc00d2909, 'Windows Media Player does not support the level of protection required for uncompressed digital audio.')

    # (0xc00d290a) Windows Media Player does not support the scheme of output protection required by the content.
    NS_E_OUTPUT_PROTECTION_SCHEME_UNSUPPORTED = HResultCode.new('NS_E_OUTPUT_PROTECTION_SCHEME_UNSUPPORTED', 0xc00d290a, 'Windows Media Player does not support the scheme of output protection required by the content.')

    # (0xc00d2afa) Installation was not successful and some file cleanup is not complete. For best results, restart your computer.
    NS_E_REBOOT_RECOMMENDED = HResultCode.new('NS_E_REBOOT_RECOMMENDED', 0xc00d2afa, 'Installation was not successful and some file cleanup is not complete. For best results, restart your computer.')

    # (0xc00d2afb) Installation was not successful. To continue, you must restart your computer.
    NS_E_REBOOT_REQUIRED = HResultCode.new('NS_E_REBOOT_REQUIRED', 0xc00d2afb, 'Installation was not successful. To continue, you must restart your computer.')

    # (0xc00d2afc) Installation was not successful.
    NS_E_SETUP_INCOMPLETE = HResultCode.new('NS_E_SETUP_INCOMPLETE', 0xc00d2afc, 'Installation was not successful.')

    # (0xc00d2afd) Setup cannot migrate the Windows Media Digital Rights Management (DRM) components.
    NS_E_SETUP_DRM_MIGRATION_FAILED = HResultCode.new('NS_E_SETUP_DRM_MIGRATION_FAILED', 0xc00d2afd, 'Setup cannot migrate the Windows Media Digital Rights Management (DRM) components.')

    # (0xc00d2afe) Some skin or playlist components cannot be installed.
    NS_E_SETUP_IGNORABLE_FAILURE = HResultCode.new('NS_E_SETUP_IGNORABLE_FAILURE', 0xc00d2afe, 'Some skin or playlist components cannot be installed.')

    # (0xc00d2aff) Setup cannot migrate the Windows Media Digital Rights Management (DRM) components. In addition, some skin or playlist components cannot be installed.
    NS_E_SETUP_DRM_MIGRATION_FAILED_AND_IGNORABLE_FAILURE = HResultCode.new('NS_E_SETUP_DRM_MIGRATION_FAILED_AND_IGNORABLE_FAILURE', 0xc00d2aff, 'Setup cannot migrate the Windows Media Digital Rights Management (DRM) components. In addition, some skin or playlist components cannot be installed.')

    # (0xc00d2b00) Installation is blocked because your computer does not meet one or more of the setup requirements.
    NS_E_SETUP_BLOCKED = HResultCode.new('NS_E_SETUP_BLOCKED', 0xc00d2b00, 'Installation is blocked because your computer does not meet one or more of the setup requirements.')

    # (0xc00d2ee0) The specified protocol is not supported.
    NS_E_UNKNOWN_PROTOCOL = HResultCode.new('NS_E_UNKNOWN_PROTOCOL', 0xc00d2ee0, 'The specified protocol is not supported.')

    # (0xc00d2ee1) The client is redirected to a proxy server.
    NS_E_REDIRECT_TO_PROXY = HResultCode.new('NS_E_REDIRECT_TO_PROXY', 0xc00d2ee1, 'The client is redirected to a proxy server.')

    # (0xc00d2ee2) The server encountered an unexpected condition which prevented it from fulfilling the request.
    NS_E_INTERNAL_SERVER_ERROR = HResultCode.new('NS_E_INTERNAL_SERVER_ERROR', 0xc00d2ee2, 'The server encountered an unexpected condition which prevented it from fulfilling the request.')

    # (0xc00d2ee3) The request could not be understood by the server.
    NS_E_BAD_REQUEST = HResultCode.new('NS_E_BAD_REQUEST', 0xc00d2ee3, 'The request could not be understood by the server.')

    # (0xc00d2ee4) The proxy experienced an error while attempting to contact the media server.
    NS_E_ERROR_FROM_PROXY = HResultCode.new('NS_E_ERROR_FROM_PROXY', 0xc00d2ee4, 'The proxy experienced an error while attempting to contact the media server.')

    # (0xc00d2ee5) The proxy did not receive a timely response while attempting to contact the media server.
    NS_E_PROXY_TIMEOUT = HResultCode.new('NS_E_PROXY_TIMEOUT', 0xc00d2ee5, 'The proxy did not receive a timely response while attempting to contact the media server.')

    # (0xc00d2ee6) The server is currently unable to handle the request due to a temporary overloading or maintenance of the server.
    NS_E_SERVER_UNAVAILABLE = HResultCode.new('NS_E_SERVER_UNAVAILABLE', 0xc00d2ee6, 'The server is currently unable to handle the request due to a temporary overloading or maintenance of the server.')

    # (0xc00d2ee7) The server is refusing to fulfill the requested operation.
    NS_E_REFUSED_BY_SERVER = HResultCode.new('NS_E_REFUSED_BY_SERVER', 0xc00d2ee7, 'The server is refusing to fulfill the requested operation.')

    # (0xc00d2ee8) The server is not a compatible streaming media server.
    NS_E_INCOMPATIBLE_SERVER = HResultCode.new('NS_E_INCOMPATIBLE_SERVER', 0xc00d2ee8, 'The server is not a compatible streaming media server.')

    # (0xc00d2ee9) The content cannot be streamed because the Multicast protocol has been disabled.
    NS_E_MULTICAST_DISABLED = HResultCode.new('NS_E_MULTICAST_DISABLED', 0xc00d2ee9, 'The content cannot be streamed because the Multicast protocol has been disabled.')

    # (0xc00d2eea) The server redirected the player to an invalid location.
    NS_E_INVALID_REDIRECT = HResultCode.new('NS_E_INVALID_REDIRECT', 0xc00d2eea, 'The server redirected the player to an invalid location.')

    # (0xc00d2eeb) The content cannot be streamed because all protocols have been disabled.
    NS_E_ALL_PROTOCOLS_DISABLED = HResultCode.new('NS_E_ALL_PROTOCOLS_DISABLED', 0xc00d2eeb, 'The content cannot be streamed because all protocols have been disabled.')

    # (0xc00d2eec) The MSBD protocol is no longer supported. Please use HTTP to connect to the Windows Media stream.
    NS_E_MSBD_NO_LONGER_SUPPORTED = HResultCode.new('NS_E_MSBD_NO_LONGER_SUPPORTED', 0xc00d2eec, 'The MSBD protocol is no longer supported. Please use HTTP to connect to the Windows Media stream.')

    # (0xc00d2eed) The proxy server could not be located. Please check your proxy server configuration.
    NS_E_PROXY_NOT_FOUND = HResultCode.new('NS_E_PROXY_NOT_FOUND', 0xc00d2eed, 'The proxy server could not be located. Please check your proxy server configuration.')

    # (0xc00d2eee) Unable to establish a connection to the proxy server. Please check your proxy server configuration.
    NS_E_CANNOT_CONNECT_TO_PROXY = HResultCode.new('NS_E_CANNOT_CONNECT_TO_PROXY', 0xc00d2eee, 'Unable to establish a connection to the proxy server. Please check your proxy server configuration.')

    # (0xc00d2eef) Unable to locate the media server. The operation timed out.
    NS_E_SERVER_DNS_TIMEOUT = HResultCode.new('NS_E_SERVER_DNS_TIMEOUT', 0xc00d2eef, 'Unable to locate the media server. The operation timed out.')

    # (0xc00d2ef0) Unable to locate the proxy server. The operation timed out.
    NS_E_PROXY_DNS_TIMEOUT = HResultCode.new('NS_E_PROXY_DNS_TIMEOUT', 0xc00d2ef0, 'Unable to locate the proxy server. The operation timed out.')

    # (0xc00d2ef1) Media closed because Windows was shut down.
    NS_E_CLOSED_ON_SUSPEND = HResultCode.new('NS_E_CLOSED_ON_SUSPEND', 0xc00d2ef1, 'Media closed because Windows was shut down.')

    # (0xc00d2ef2) Unable to read the contents of a playlist file from a media server.
    NS_E_CANNOT_READ_PLAYLIST_FROM_MEDIASERVER = HResultCode.new('NS_E_CANNOT_READ_PLAYLIST_FROM_MEDIASERVER', 0xc00d2ef2, 'Unable to read the contents of a playlist file from a media server.')

    # (0xc00d2ef3) Session not found.
    NS_E_SESSION_NOT_FOUND = HResultCode.new('NS_E_SESSION_NOT_FOUND', 0xc00d2ef3, 'Session not found.')

    # (0xc00d2ef4) Content requires a streaming media client.
    NS_E_REQUIRE_STREAMING_CLIENT = HResultCode.new('NS_E_REQUIRE_STREAMING_CLIENT', 0xc00d2ef4, 'Content requires a streaming media client.')

    # (0xc00d2ef5) A command applies to a previous playlist entry.
    NS_E_PLAYLIST_ENTRY_HAS_CHANGED = HResultCode.new('NS_E_PLAYLIST_ENTRY_HAS_CHANGED', 0xc00d2ef5, 'A command applies to a previous playlist entry.')

    # (0xc00d2ef6) The proxy server is denying access. The username and/or password might be incorrect.
    NS_E_PROXY_ACCESSDENIED = HResultCode.new('NS_E_PROXY_ACCESSDENIED', 0xc00d2ef6, 'The proxy server is denying access. The username and/or password might be incorrect.')

    # (0xc00d2ef7) The proxy could not provide valid authentication credentials to the media server.
    NS_E_PROXY_SOURCE_ACCESSDENIED = HResultCode.new('NS_E_PROXY_SOURCE_ACCESSDENIED', 0xc00d2ef7, 'The proxy could not provide valid authentication credentials to the media server.')

    # (0xc00d2ef8) The network sink failed to write data to the network.
    NS_E_NETWORK_SINK_WRITE = HResultCode.new('NS_E_NETWORK_SINK_WRITE', 0xc00d2ef8, 'The network sink failed to write data to the network.')

    # (0xc00d2ef9) Packets are not being received from the server. The packets might be blocked by a filtering device, such as a network firewall.
    NS_E_FIREWALL = HResultCode.new('NS_E_FIREWALL', 0xc00d2ef9, 'Packets are not being received from the server. The packets might be blocked by a filtering device, such as a network firewall.')

    # (0xc00d2efa) The MMS protocol is not supported. Please use HTTP or RTSP to connect to the Windows Media stream.
    NS_E_MMS_NOT_SUPPORTED = HResultCode.new('NS_E_MMS_NOT_SUPPORTED', 0xc00d2efa, 'The MMS protocol is not supported. Please use HTTP or RTSP to connect to the Windows Media stream.')

    # (0xc00d2efb) The Windows Media server is denying access. The username and/or password might be incorrect.
    NS_E_SERVER_ACCESSDENIED = HResultCode.new('NS_E_SERVER_ACCESSDENIED', 0xc00d2efb, 'The Windows Media server is denying access. The username and/or password might be incorrect.')

    # (0xc00d2efc) The Publishing Point or file on the Windows Media Server is no longer available.
    NS_E_RESOURCE_GONE = HResultCode.new('NS_E_RESOURCE_GONE', 0xc00d2efc, 'The Publishing Point or file on the Windows Media Server is no longer available.')

    # (0xc00d2efd) There is no existing packetizer plugin for a stream.
    NS_E_NO_EXISTING_PACKETIZER = HResultCode.new('NS_E_NO_EXISTING_PACKETIZER', 0xc00d2efd, 'There is no existing packetizer plugin for a stream.')

    # (0xc00d2efe) The response from the media server could not be understood. This might be caused by an incompatible proxy server or media server.
    NS_E_BAD_SYNTAX_IN_SERVER_RESPONSE = HResultCode.new('NS_E_BAD_SYNTAX_IN_SERVER_RESPONSE', 0xc00d2efe, 'The response from the media server could not be understood. This might be caused by an incompatible proxy server or media server.')

    # (0xc00d2f00) The Windows Media Server reset the network connection.
    NS_E_RESET_SOCKET_CONNECTION = HResultCode.new('NS_E_RESET_SOCKET_CONNECTION', 0xc00d2f00, 'The Windows Media Server reset the network connection.')

    # (0xc00d2f02) The request could not reach the media server (too many hops).
    NS_E_TOO_MANY_HOPS = HResultCode.new('NS_E_TOO_MANY_HOPS', 0xc00d2f02, 'The request could not reach the media server (too many hops).')

    # (0xc00d2f05) The server is sending too much data. The connection has been terminated.
    NS_E_TOO_MUCH_DATA_FROM_SERVER = HResultCode.new('NS_E_TOO_MUCH_DATA_FROM_SERVER', 0xc00d2f05, 'The server is sending too much data. The connection has been terminated.')

    # (0xc00d2f06) It was not possible to establish a connection to the media server in a timely manner. The media server might be down for maintenance, or it might be necessary to use a proxy server to access this media server.
    NS_E_CONNECT_TIMEOUT = HResultCode.new('NS_E_CONNECT_TIMEOUT', 0xc00d2f06, 'It was not possible to establish a connection to the media server in a timely manner. The media server might be down for maintenance, or it might be necessary to use a proxy server to access this media server.')

    # (0xc00d2f07) It was not possible to establish a connection to the proxy server in a timely manner. Please check your proxy server configuration.
    NS_E_PROXY_CONNECT_TIMEOUT = HResultCode.new('NS_E_PROXY_CONNECT_TIMEOUT', 0xc00d2f07, 'It was not possible to establish a connection to the proxy server in a timely manner. Please check your proxy server configuration.')

    # (0xc00d2f08) Session not found.
    NS_E_SESSION_INVALID = HResultCode.new('NS_E_SESSION_INVALID', 0xc00d2f08, 'Session not found.')

    # (0xc00d2f0a) Unknown packet sink stream.
    NS_E_PACKETSINK_UNKNOWN_FEC_STREAM = HResultCode.new('NS_E_PACKETSINK_UNKNOWN_FEC_STREAM', 0xc00d2f0a, 'Unknown packet sink stream.')

    # (0xc00d2f0b) Unable to establish a connection to the server. Ensure Windows Media Services is started and the HTTP Server control protocol is properly enabled.
    NS_E_PUSH_CANNOTCONNECT = HResultCode.new('NS_E_PUSH_CANNOTCONNECT', 0xc00d2f0b, 'Unable to establish a connection to the server. Ensure Windows Media Services is started and the HTTP Server control protocol is properly enabled.')

    # (0xc00d2f0c) The Server service that received the HTTP push request is not a compatible version of Windows Media Services (WMS). This error might indicate the push request was received by IIS instead of WMS. Ensure WMS is started and has the HTTP Server control protocol properly enabled and try again.
    NS_E_INCOMPATIBLE_PUSH_SERVER = HResultCode.new('NS_E_INCOMPATIBLE_PUSH_SERVER', 0xc00d2f0c, 'The Server service that received the HTTP push request is not a compatible version of Windows Media Services (WMS). This error might indicate the push request was received by IIS instead of WMS. Ensure WMS is started and has the HTTP Server control protocol properly enabled and try again.')

    # (0xc00d32c8) The playlist has reached its end.
    NS_E_END_OF_PLAYLIST = HResultCode.new('NS_E_END_OF_PLAYLIST', 0xc00d32c8, 'The playlist has reached its end.')

    # (0xc00d32c9) Use file source.
    NS_E_USE_FILE_SOURCE = HResultCode.new('NS_E_USE_FILE_SOURCE', 0xc00d32c9, 'Use file source.')

    # (0xc00d32ca) The property was not found.
    NS_E_PROPERTY_NOT_FOUND = HResultCode.new('NS_E_PROPERTY_NOT_FOUND', 0xc00d32ca, 'The property was not found.')

    # (0xc00d32cc) The property is read only.
    NS_E_PROPERTY_READ_ONLY = HResultCode.new('NS_E_PROPERTY_READ_ONLY', 0xc00d32cc, 'The property is read only.')

    # (0xc00d32cd) The table key was not found.
    NS_E_TABLE_KEY_NOT_FOUND = HResultCode.new('NS_E_TABLE_KEY_NOT_FOUND', 0xc00d32cd, 'The table key was not found.')

    # (0xc00d32cf) Invalid query operator.
    NS_E_INVALID_QUERY_OPERATOR = HResultCode.new('NS_E_INVALID_QUERY_OPERATOR', 0xc00d32cf, 'Invalid query operator.')

    # (0xc00d32d0) Invalid query property.
    NS_E_INVALID_QUERY_PROPERTY = HResultCode.new('NS_E_INVALID_QUERY_PROPERTY', 0xc00d32d0, 'Invalid query property.')

    # (0xc00d32d2) The property is not supported.
    NS_E_PROPERTY_NOT_SUPPORTED = HResultCode.new('NS_E_PROPERTY_NOT_SUPPORTED', 0xc00d32d2, 'The property is not supported.')

    # (0xc00d32d4) Schema classification failure.
    NS_E_SCHEMA_CLASSIFY_FAILURE = HResultCode.new('NS_E_SCHEMA_CLASSIFY_FAILURE', 0xc00d32d4, 'Schema classification failure.')

    # (0xc00d32d5) The metadata format is not supported.
    NS_E_METADATA_FORMAT_NOT_SUPPORTED = HResultCode.new('NS_E_METADATA_FORMAT_NOT_SUPPORTED', 0xc00d32d5, 'The metadata format is not supported.')

    # (0xc00d32d6) Cannot edit the metadata.
    NS_E_METADATA_NO_EDITING_CAPABILITY = HResultCode.new('NS_E_METADATA_NO_EDITING_CAPABILITY', 0xc00d32d6, 'Cannot edit the metadata.')

    # (0xc00d32d7) Cannot set the locale id.
    NS_E_METADATA_CANNOT_SET_LOCALE = HResultCode.new('NS_E_METADATA_CANNOT_SET_LOCALE', 0xc00d32d7, 'Cannot set the locale id.')

    # (0xc00d32d8) The language is not supported in the format.
    NS_E_METADATA_LANGUAGE_NOT_SUPORTED = HResultCode.new('NS_E_METADATA_LANGUAGE_NOT_SUPORTED', 0xc00d32d8, 'The language is not supported in the format.')

    # (0xc00d32d9) There is no RFC1766 name translation for the supplied locale id.
    NS_E_METADATA_NO_RFC1766_NAME_FOR_LOCALE = HResultCode.new('NS_E_METADATA_NO_RFC1766_NAME_FOR_LOCALE', 0xc00d32d9, 'There is no RFC1766 name translation for the supplied locale id.')

    # (0xc00d32da) The metadata (or metadata item) is not available.
    NS_E_METADATA_NOT_AVAILABLE = HResultCode.new('NS_E_METADATA_NOT_AVAILABLE', 0xc00d32da, 'The metadata (or metadata item) is not available.')

    # (0xc00d32db) The cached metadata (or metadata item) is not available.
    NS_E_METADATA_CACHE_DATA_NOT_AVAILABLE = HResultCode.new('NS_E_METADATA_CACHE_DATA_NOT_AVAILABLE', 0xc00d32db, 'The cached metadata (or metadata item) is not available.')

    # (0xc00d32dc) The metadata document is invalid.
    NS_E_METADATA_INVALID_DOCUMENT_TYPE = HResultCode.new('NS_E_METADATA_INVALID_DOCUMENT_TYPE', 0xc00d32dc, 'The metadata document is invalid.')

    # (0xc00d32dd) The metadata content identifier is not available.
    NS_E_METADATA_IDENTIFIER_NOT_AVAILABLE = HResultCode.new('NS_E_METADATA_IDENTIFIER_NOT_AVAILABLE', 0xc00d32dd, 'The metadata content identifier is not available.')

    # (0xc00d32de) Cannot retrieve metadata from the offline metadata cache.
    NS_E_METADATA_CANNOT_RETRIEVE_FROM_OFFLINE_CACHE = HResultCode.new('NS_E_METADATA_CANNOT_RETRIEVE_FROM_OFFLINE_CACHE', 0xc00d32de, 'Cannot retrieve metadata from the offline metadata cache.')

    # (0xc0261003) Checksum of the obtained monitor descriptor is invalid.
    ERROR_MONITOR_INVALID_DESCRIPTOR_CHECKSUM = HResultCode.new('ERROR_MONITOR_INVALID_DESCRIPTOR_CHECKSUM', 0xc0261003, 'Checksum of the obtained monitor descriptor is invalid.')

    # (0xc0261004) Monitor descriptor contains an invalid standard timing block.
    ERROR_MONITOR_INVALID_STANDARD_TIMING_BLOCK = HResultCode.new('ERROR_MONITOR_INVALID_STANDARD_TIMING_BLOCK', 0xc0261004, 'Monitor descriptor contains an invalid standard timing block.')

    # (0xc0261005) Windows Management Instrumentation (WMI) data block registration failed for one of the MSMonitorClass WMI subclasses.
    ERROR_MONITOR_WMI_DATABLOCK_REGISTRATION_FAILED = HResultCode.new('ERROR_MONITOR_WMI_DATABLOCK_REGISTRATION_FAILED', 0xc0261005, 'Windows Management Instrumentation (WMI) data block registration failed for one of the MSMonitorClass WMI subclasses.')

    # (0xc0261006) Provided monitor descriptor block is either corrupted or does not contain the monitor's detailed serial number.
    ERROR_MONITOR_INVALID_SERIAL_NUMBER_MONDSC_BLOCK = HResultCode.new('ERROR_MONITOR_INVALID_SERIAL_NUMBER_MONDSC_BLOCK', 0xc0261006, 'Provided monitor descriptor block is either corrupted or does not contain the monitor\'s detailed serial number.')

    # (0xc0261007) Provided monitor descriptor block is either corrupted or does not contain the monitor's user-friendly name.
    ERROR_MONITOR_INVALID_USER_FRIENDLY_MONDSC_BLOCK = HResultCode.new('ERROR_MONITOR_INVALID_USER_FRIENDLY_MONDSC_BLOCK', 0xc0261007, 'Provided monitor descriptor block is either corrupted or does not contain the monitor\'s user-friendly name.')

    # (0xc0261008) There is no monitor descriptor data at the specified (offset, size) region.
    ERROR_MONITOR_NO_MORE_DESCRIPTOR_DATA = HResultCode.new('ERROR_MONITOR_NO_MORE_DESCRIPTOR_DATA', 0xc0261008, 'There is no monitor descriptor data at the specified (offset, size) region.')

    # (0xc0261009) Monitor descriptor contains an invalid detailed timing block.
    ERROR_MONITOR_INVALID_DETAILED_TIMING_BLOCK = HResultCode.new('ERROR_MONITOR_INVALID_DETAILED_TIMING_BLOCK', 0xc0261009, 'Monitor descriptor contains an invalid detailed timing block.')

    # (0xc0262000) Exclusive mode ownership is needed to create unmanaged primary allocation.
    ERROR_GRAPHICS_NOT_EXCLUSIVE_MODE_OWNER = HResultCode.new('ERROR_GRAPHICS_NOT_EXCLUSIVE_MODE_OWNER', 0xc0262000, 'Exclusive mode ownership is needed to create unmanaged primary allocation.')

    # (0xc0262001) The driver needs more direct memory access (DMA) buffer space to complete the requested operation.
    ERROR_GRAPHICS_INSUFFICIENT_DMA_BUFFER = HResultCode.new('ERROR_GRAPHICS_INSUFFICIENT_DMA_BUFFER', 0xc0262001, 'The driver needs more direct memory access (DMA) buffer space to complete the requested operation.')

    # (0xc0262002) Specified display adapter handle is invalid.
    ERROR_GRAPHICS_INVALID_DISPLAY_ADAPTER = HResultCode.new('ERROR_GRAPHICS_INVALID_DISPLAY_ADAPTER', 0xc0262002, 'Specified display adapter handle is invalid.')

    # (0xc0262003) Specified display adapter and all of its state has been reset.
    ERROR_GRAPHICS_ADAPTER_WAS_RESET = HResultCode.new('ERROR_GRAPHICS_ADAPTER_WAS_RESET', 0xc0262003, 'Specified display adapter and all of its state has been reset.')

    # (0xc0262004) The driver stack does not match the expected driver model.
    ERROR_GRAPHICS_INVALID_DRIVER_MODEL = HResultCode.new('ERROR_GRAPHICS_INVALID_DRIVER_MODEL', 0xc0262004, 'The driver stack does not match the expected driver model.')

    # (0xc0262005) Present happened but ended up into the changed desktop mode.
    ERROR_GRAPHICS_PRESENT_MODE_CHANGED = HResultCode.new('ERROR_GRAPHICS_PRESENT_MODE_CHANGED', 0xc0262005, 'Present happened but ended up into the changed desktop mode.')

    # (0xc0262006) Nothing to present due to desktop occlusion.
    ERROR_GRAPHICS_PRESENT_OCCLUDED = HResultCode.new('ERROR_GRAPHICS_PRESENT_OCCLUDED', 0xc0262006, 'Nothing to present due to desktop occlusion.')

    # (0xc0262007) Not able to present due to denial of desktop access.
    ERROR_GRAPHICS_PRESENT_DENIED = HResultCode.new('ERROR_GRAPHICS_PRESENT_DENIED', 0xc0262007, 'Not able to present due to denial of desktop access.')

    # (0xc0262008) Not able to present with color conversion.
    ERROR_GRAPHICS_CANNOTCOLORCONVERT = HResultCode.new('ERROR_GRAPHICS_CANNOTCOLORCONVERT', 0xc0262008, 'Not able to present with color conversion.')

    # (0xc0262100) Not enough video memory available to complete the operation.
    ERROR_GRAPHICS_NO_VIDEO_MEMORY = HResultCode.new('ERROR_GRAPHICS_NO_VIDEO_MEMORY', 0xc0262100, 'Not enough video memory available to complete the operation.')

    # (0xc0262101) Could not probe and lock the underlying memory of an allocation.
    ERROR_GRAPHICS_CANT_LOCK_MEMORY = HResultCode.new('ERROR_GRAPHICS_CANT_LOCK_MEMORY', 0xc0262101, 'Could not probe and lock the underlying memory of an allocation.')

    # (0xc0262102) The allocation is currently busy.
    ERROR_GRAPHICS_ALLOCATION_BUSY = HResultCode.new('ERROR_GRAPHICS_ALLOCATION_BUSY', 0xc0262102, 'The allocation is currently busy.')

    # (0xc0262103) An object being referenced has reach the maximum reference count already and cannot be referenced further.
    ERROR_GRAPHICS_TOO_MANY_REFERENCES = HResultCode.new('ERROR_GRAPHICS_TOO_MANY_REFERENCES', 0xc0262103, 'An object being referenced has reach the maximum reference count already and cannot be referenced further.')

    # (0xc0262104) A problem could not be solved due to some currently existing condition. The problem should be tried again later.
    ERROR_GRAPHICS_TRY_AGAIN_LATER = HResultCode.new('ERROR_GRAPHICS_TRY_AGAIN_LATER', 0xc0262104, 'A problem could not be solved due to some currently existing condition. The problem should be tried again later.')

    # (0xc0262105) A problem could not be solved due to some currently existing condition. The problem should be tried again immediately.
    ERROR_GRAPHICS_TRY_AGAIN_NOW = HResultCode.new('ERROR_GRAPHICS_TRY_AGAIN_NOW', 0xc0262105, 'A problem could not be solved due to some currently existing condition. The problem should be tried again immediately.')

    # (0xc0262106) The allocation is invalid.
    ERROR_GRAPHICS_ALLOCATION_INVALID = HResultCode.new('ERROR_GRAPHICS_ALLOCATION_INVALID', 0xc0262106, 'The allocation is invalid.')

    # (0xc0262107) No more unswizzling apertures are currently available.
    ERROR_GRAPHICS_UNSWIZZLING_APERTURE_UNAVAILABLE = HResultCode.new('ERROR_GRAPHICS_UNSWIZZLING_APERTURE_UNAVAILABLE', 0xc0262107, 'No more unswizzling apertures are currently available.')

    # (0xc0262108) The current allocation cannot be unswizzled by an aperture.
    ERROR_GRAPHICS_UNSWIZZLING_APERTURE_UNSUPPORTED = HResultCode.new('ERROR_GRAPHICS_UNSWIZZLING_APERTURE_UNSUPPORTED', 0xc0262108, 'The current allocation cannot be unswizzled by an aperture.')

    # (0xc0262109) The request failed because a pinned allocation cannot be evicted.
    ERROR_GRAPHICS_CANT_EVICT_PINNED_ALLOCATION = HResultCode.new('ERROR_GRAPHICS_CANT_EVICT_PINNED_ALLOCATION', 0xc0262109, 'The request failed because a pinned allocation cannot be evicted.')

    # (0xc0262110) The allocation cannot be used from its current segment location for the specified operation.
    ERROR_GRAPHICS_INVALID_ALLOCATION_USAGE = HResultCode.new('ERROR_GRAPHICS_INVALID_ALLOCATION_USAGE', 0xc0262110, 'The allocation cannot be used from its current segment location for the specified operation.')

    # (0xc0262111) A locked allocation cannot be used in the current command buffer.
    ERROR_GRAPHICS_CANT_RENDER_LOCKED_ALLOCATION = HResultCode.new('ERROR_GRAPHICS_CANT_RENDER_LOCKED_ALLOCATION', 0xc0262111, 'A locked allocation cannot be used in the current command buffer.')

    # (0xc0262112) The allocation being referenced has been closed permanently.
    ERROR_GRAPHICS_ALLOCATION_CLOSED = HResultCode.new('ERROR_GRAPHICS_ALLOCATION_CLOSED', 0xc0262112, 'The allocation being referenced has been closed permanently.')

    # (0xc0262113) An invalid allocation instance is being referenced.
    ERROR_GRAPHICS_INVALID_ALLOCATION_INSTANCE = HResultCode.new('ERROR_GRAPHICS_INVALID_ALLOCATION_INSTANCE', 0xc0262113, 'An invalid allocation instance is being referenced.')

    # (0xc0262114) An invalid allocation handle is being referenced.
    ERROR_GRAPHICS_INVALID_ALLOCATION_HANDLE = HResultCode.new('ERROR_GRAPHICS_INVALID_ALLOCATION_HANDLE', 0xc0262114, 'An invalid allocation handle is being referenced.')

    # (0xc0262115) The allocation being referenced does not belong to the current device.
    ERROR_GRAPHICS_WRONG_ALLOCATION_DEVICE = HResultCode.new('ERROR_GRAPHICS_WRONG_ALLOCATION_DEVICE', 0xc0262115, 'The allocation being referenced does not belong to the current device.')

    # (0xc0262116) The specified allocation lost its content.
    ERROR_GRAPHICS_ALLOCATION_CONTENT_LOST = HResultCode.new('ERROR_GRAPHICS_ALLOCATION_CONTENT_LOST', 0xc0262116, 'The specified allocation lost its content.')

    # (0xc0262200) Graphics processing unit (GPU) exception is detected on the given device. The device is not able to be scheduled.
    ERROR_GRAPHICS_GPU_EXCEPTION_ON_DEVICE = HResultCode.new('ERROR_GRAPHICS_GPU_EXCEPTION_ON_DEVICE', 0xc0262200, 'Graphics processing unit (GPU) exception is detected on the given device. The device is not able to be scheduled.')

    # (0xc0262300) Specified video present network (VidPN) topology is invalid.
    ERROR_GRAPHICS_INVALID_VIDPN_TOPOLOGY = HResultCode.new('ERROR_GRAPHICS_INVALID_VIDPN_TOPOLOGY', 0xc0262300, 'Specified video present network (VidPN) topology is invalid.')

    # (0xc0262301) Specified VidPN topology is valid but is not supported by this model of the display adapter.
    ERROR_GRAPHICS_VIDPN_TOPOLOGY_NOT_SUPPORTED = HResultCode.new('ERROR_GRAPHICS_VIDPN_TOPOLOGY_NOT_SUPPORTED', 0xc0262301, 'Specified VidPN topology is valid but is not supported by this model of the display adapter.')

    # (0xc0262302) Specified VidPN topology is valid but is not supported by the display adapter at this time, due to current allocation of its resources.
    ERROR_GRAPHICS_VIDPN_TOPOLOGY_CURRENTLY_NOT_SUPPORTED = HResultCode.new('ERROR_GRAPHICS_VIDPN_TOPOLOGY_CURRENTLY_NOT_SUPPORTED', 0xc0262302, 'Specified VidPN topology is valid but is not supported by the display adapter at this time, due to current allocation of its resources.')

    # (0xc0262303) Specified VidPN handle is invalid.
    ERROR_GRAPHICS_INVALID_VIDPN = HResultCode.new('ERROR_GRAPHICS_INVALID_VIDPN', 0xc0262303, 'Specified VidPN handle is invalid.')

    # (0xc0262304) Specified video present source is invalid.
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE = HResultCode.new('ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE', 0xc0262304, 'Specified video present source is invalid.')

    # (0xc0262305) Specified video present target is invalid.
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET = HResultCode.new('ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET', 0xc0262305, 'Specified video present target is invalid.')

    # (0xc0262306) Specified VidPN modality is not supported (for example, at least two of the pinned modes are not cofunctional).
    ERROR_GRAPHICS_VIDPN_MODALITY_NOT_SUPPORTED = HResultCode.new('ERROR_GRAPHICS_VIDPN_MODALITY_NOT_SUPPORTED', 0xc0262306, 'Specified VidPN modality is not supported (for example, at least two of the pinned modes are not cofunctional).')

    # (0xc0262308) Specified VidPN source mode set is invalid.
    ERROR_GRAPHICS_INVALID_VIDPN_SOURCEMODESET = HResultCode.new('ERROR_GRAPHICS_INVALID_VIDPN_SOURCEMODESET', 0xc0262308, 'Specified VidPN source mode set is invalid.')

    # (0xc0262309) Specified VidPN target mode set is invalid.
    ERROR_GRAPHICS_INVALID_VIDPN_TARGETMODESET = HResultCode.new('ERROR_GRAPHICS_INVALID_VIDPN_TARGETMODESET', 0xc0262309, 'Specified VidPN target mode set is invalid.')

    # (0xc026230a) Specified video signal frequency is invalid.
    ERROR_GRAPHICS_INVALID_FREQUENCY = HResultCode.new('ERROR_GRAPHICS_INVALID_FREQUENCY', 0xc026230a, 'Specified video signal frequency is invalid.')

    # (0xc026230b) Specified video signal active region is invalid.
    ERROR_GRAPHICS_INVALID_ACTIVE_REGION = HResultCode.new('ERROR_GRAPHICS_INVALID_ACTIVE_REGION', 0xc026230b, 'Specified video signal active region is invalid.')

    # (0xc026230c) Specified video signal total region is invalid.
    ERROR_GRAPHICS_INVALID_TOTAL_REGION = HResultCode.new('ERROR_GRAPHICS_INVALID_TOTAL_REGION', 0xc026230c, 'Specified video signal total region is invalid.')

    # (0xc0262310) Specified video present source mode is invalid.
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE_MODE = HResultCode.new('ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE_MODE', 0xc0262310, 'Specified video present source mode is invalid.')

    # (0xc0262311) Specified video present target mode is invalid.
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET_MODE = HResultCode.new('ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET_MODE', 0xc0262311, 'Specified video present target mode is invalid.')

    # (0xc0262312) Pinned mode must remain in the set on VidPN's cofunctional modality enumeration.
    ERROR_GRAPHICS_PINNED_MODE_MUST_REMAIN_IN_SET = HResultCode.new('ERROR_GRAPHICS_PINNED_MODE_MUST_REMAIN_IN_SET', 0xc0262312, 'Pinned mode must remain in the set on VidPN\'s cofunctional modality enumeration.')

    # (0xc0262313) Specified video present path is already in the VidPN topology.
    ERROR_GRAPHICS_PATH_ALREADY_IN_TOPOLOGY = HResultCode.new('ERROR_GRAPHICS_PATH_ALREADY_IN_TOPOLOGY', 0xc0262313, 'Specified video present path is already in the VidPN topology.')

    # (0xc0262314) Specified mode is already in the mode set.
    ERROR_GRAPHICS_MODE_ALREADY_IN_MODESET = HResultCode.new('ERROR_GRAPHICS_MODE_ALREADY_IN_MODESET', 0xc0262314, 'Specified mode is already in the mode set.')

    # (0xc0262315) Specified video present source set is invalid.
    ERROR_GRAPHICS_INVALID_VIDEOPRESENTSOURCESET = HResultCode.new('ERROR_GRAPHICS_INVALID_VIDEOPRESENTSOURCESET', 0xc0262315, 'Specified video present source set is invalid.')

    # (0xc0262316) Specified video present target set is invalid.
    ERROR_GRAPHICS_INVALID_VIDEOPRESENTTARGETSET = HResultCode.new('ERROR_GRAPHICS_INVALID_VIDEOPRESENTTARGETSET', 0xc0262316, 'Specified video present target set is invalid.')

    # (0xc0262317) Specified video present source is already in the video present source set.
    ERROR_GRAPHICS_SOURCE_ALREADY_IN_SET = HResultCode.new('ERROR_GRAPHICS_SOURCE_ALREADY_IN_SET', 0xc0262317, 'Specified video present source is already in the video present source set.')

    # (0xc0262318) Specified video present target is already in the video present target set.
    ERROR_GRAPHICS_TARGET_ALREADY_IN_SET = HResultCode.new('ERROR_GRAPHICS_TARGET_ALREADY_IN_SET', 0xc0262318, 'Specified video present target is already in the video present target set.')

    # (0xc0262319) Specified VidPN present path is invalid.
    ERROR_GRAPHICS_INVALID_VIDPN_PRESENT_PATH = HResultCode.new('ERROR_GRAPHICS_INVALID_VIDPN_PRESENT_PATH', 0xc0262319, 'Specified VidPN present path is invalid.')

    # (0xc026231a) Miniport has no recommendation for augmentation of the specified VidPN topology.
    ERROR_GRAPHICS_NO_RECOMMENDED_VIDPN_TOPOLOGY = HResultCode.new('ERROR_GRAPHICS_NO_RECOMMENDED_VIDPN_TOPOLOGY', 0xc026231a, 'Miniport has no recommendation for augmentation of the specified VidPN topology.')

    # (0xc026231b) Specified monitor frequency range set is invalid.
    ERROR_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGESET = HResultCode.new('ERROR_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGESET', 0xc026231b, 'Specified monitor frequency range set is invalid.')

    # (0xc026231c) Specified monitor frequency range is invalid.
    ERROR_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE = HResultCode.new('ERROR_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE', 0xc026231c, 'Specified monitor frequency range is invalid.')

    # (0xc026231d) Specified frequency range is not in the specified monitor frequency range set.
    ERROR_GRAPHICS_FREQUENCYRANGE_NOT_IN_SET = HResultCode.new('ERROR_GRAPHICS_FREQUENCYRANGE_NOT_IN_SET', 0xc026231d, 'Specified frequency range is not in the specified monitor frequency range set.')

    # (0xc026231f) Specified frequency range is already in the specified monitor frequency range set.
    ERROR_GRAPHICS_FREQUENCYRANGE_ALREADY_IN_SET = HResultCode.new('ERROR_GRAPHICS_FREQUENCYRANGE_ALREADY_IN_SET', 0xc026231f, 'Specified frequency range is already in the specified monitor frequency range set.')

    # (0xc0262320) Specified mode set is stale. Reacquire the new mode set.
    ERROR_GRAPHICS_STALE_MODESET = HResultCode.new('ERROR_GRAPHICS_STALE_MODESET', 0xc0262320, 'Specified mode set is stale. Reacquire the new mode set.')

    # (0xc0262321) Specified monitor source mode set is invalid.
    ERROR_GRAPHICS_INVALID_MONITOR_SOURCEMODESET = HResultCode.new('ERROR_GRAPHICS_INVALID_MONITOR_SOURCEMODESET', 0xc0262321, 'Specified monitor source mode set is invalid.')

    # (0xc0262322) Specified monitor source mode is invalid.
    ERROR_GRAPHICS_INVALID_MONITOR_SOURCE_MODE = HResultCode.new('ERROR_GRAPHICS_INVALID_MONITOR_SOURCE_MODE', 0xc0262322, 'Specified monitor source mode is invalid.')

    # (0xc0262323) Miniport does not have any recommendation regarding the request to provide a functional VidPN given the current display adapter configuration.
    ERROR_GRAPHICS_NO_RECOMMENDED_FUNCTIONAL_VIDPN = HResultCode.new('ERROR_GRAPHICS_NO_RECOMMENDED_FUNCTIONAL_VIDPN', 0xc0262323, 'Miniport does not have any recommendation regarding the request to provide a functional VidPN given the current display adapter configuration.')

    # (0xc0262324) ID of the specified mode is already used by another mode in the set.
    ERROR_GRAPHICS_MODE_ID_MUST_BE_UNIQUE = HResultCode.new('ERROR_GRAPHICS_MODE_ID_MUST_BE_UNIQUE', 0xc0262324, 'ID of the specified mode is already used by another mode in the set.')

    # (0xc0262325) System failed to determine a mode that is supported by both the display adapter and the monitor connected to it.
    ERROR_GRAPHICS_EMPTY_ADAPTER_MONITOR_MODE_SUPPORT_INTERSECTION = HResultCode.new('ERROR_GRAPHICS_EMPTY_ADAPTER_MONITOR_MODE_SUPPORT_INTERSECTION', 0xc0262325, 'System failed to determine a mode that is supported by both the display adapter and the monitor connected to it.')

    # (0xc0262326) Number of video present targets must be greater than or equal to the number of video present sources.
    ERROR_GRAPHICS_VIDEO_PRESENT_TARGETS_LESS_THAN_SOURCES = HResultCode.new('ERROR_GRAPHICS_VIDEO_PRESENT_TARGETS_LESS_THAN_SOURCES', 0xc0262326, 'Number of video present targets must be greater than or equal to the number of video present sources.')

    # (0xc0262327) Specified present path is not in the VidPN topology.
    ERROR_GRAPHICS_PATH_NOT_IN_TOPOLOGY = HResultCode.new('ERROR_GRAPHICS_PATH_NOT_IN_TOPOLOGY', 0xc0262327, 'Specified present path is not in the VidPN topology.')

    # (0xc0262328) Display adapter must have at least one video present source.
    ERROR_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_SOURCE = HResultCode.new('ERROR_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_SOURCE', 0xc0262328, 'Display adapter must have at least one video present source.')

    # (0xc0262329) Display adapter must have at least one video present target.
    ERROR_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_TARGET = HResultCode.new('ERROR_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_TARGET', 0xc0262329, 'Display adapter must have at least one video present target.')

    # (0xc026232a) Specified monitor descriptor set is invalid.
    ERROR_GRAPHICS_INVALID_MONITORDESCRIPTORSET = HResultCode.new('ERROR_GRAPHICS_INVALID_MONITORDESCRIPTORSET', 0xc026232a, 'Specified monitor descriptor set is invalid.')

    # (0xc026232b) Specified monitor descriptor is invalid.
    ERROR_GRAPHICS_INVALID_MONITORDESCRIPTOR = HResultCode.new('ERROR_GRAPHICS_INVALID_MONITORDESCRIPTOR', 0xc026232b, 'Specified monitor descriptor is invalid.')

    # (0xc026232c) Specified descriptor is not in the specified monitor descriptor set.
    ERROR_GRAPHICS_MONITORDESCRIPTOR_NOT_IN_SET = HResultCode.new('ERROR_GRAPHICS_MONITORDESCRIPTOR_NOT_IN_SET', 0xc026232c, 'Specified descriptor is not in the specified monitor descriptor set.')

    # (0xc026232d) Specified descriptor is already in the specified monitor descriptor set.
    ERROR_GRAPHICS_MONITORDESCRIPTOR_ALREADY_IN_SET = HResultCode.new('ERROR_GRAPHICS_MONITORDESCRIPTOR_ALREADY_IN_SET', 0xc026232d, 'Specified descriptor is already in the specified monitor descriptor set.')

    # (0xc026232e) ID of the specified monitor descriptor is already used by another descriptor in the set.
    ERROR_GRAPHICS_MONITORDESCRIPTOR_ID_MUST_BE_UNIQUE = HResultCode.new('ERROR_GRAPHICS_MONITORDESCRIPTOR_ID_MUST_BE_UNIQUE', 0xc026232e, 'ID of the specified monitor descriptor is already used by another descriptor in the set.')

    # (0xc026232f) Specified video present target subset type is invalid.
    ERROR_GRAPHICS_INVALID_VIDPN_TARGET_SUBSET_TYPE = HResultCode.new('ERROR_GRAPHICS_INVALID_VIDPN_TARGET_SUBSET_TYPE', 0xc026232f, 'Specified video present target subset type is invalid.')

    # (0xc0262330) Two or more of the specified resources are not related to each other, as defined by the interface semantics.
    ERROR_GRAPHICS_RESOURCES_NOT_RELATED = HResultCode.new('ERROR_GRAPHICS_RESOURCES_NOT_RELATED', 0xc0262330, 'Two or more of the specified resources are not related to each other, as defined by the interface semantics.')

    # (0xc0262331) ID of the specified video present source is already used by another source in the set.
    ERROR_GRAPHICS_SOURCE_ID_MUST_BE_UNIQUE = HResultCode.new('ERROR_GRAPHICS_SOURCE_ID_MUST_BE_UNIQUE', 0xc0262331, 'ID of the specified video present source is already used by another source in the set.')

    # (0xc0262332) ID of the specified video present target is already used by another target in the set.
    ERROR_GRAPHICS_TARGET_ID_MUST_BE_UNIQUE = HResultCode.new('ERROR_GRAPHICS_TARGET_ID_MUST_BE_UNIQUE', 0xc0262332, 'ID of the specified video present target is already used by another target in the set.')

    # (0xc0262333) Specified VidPN source cannot be used because there is no available VidPN target to connect it to.
    ERROR_GRAPHICS_NO_AVAILABLE_VIDPN_TARGET = HResultCode.new('ERROR_GRAPHICS_NO_AVAILABLE_VIDPN_TARGET', 0xc0262333, 'Specified VidPN source cannot be used because there is no available VidPN target to connect it to.')

    # (0xc0262334) Newly arrived monitor could not be associated with a display adapter.
    ERROR_GRAPHICS_MONITOR_COULD_NOT_BE_ASSOCIATED_WITH_ADAPTER = HResultCode.new('ERROR_GRAPHICS_MONITOR_COULD_NOT_BE_ASSOCIATED_WITH_ADAPTER', 0xc0262334, 'Newly arrived monitor could not be associated with a display adapter.')

    # (0xc0262335) Display adapter in question does not have an associated VidPN manager.
    ERROR_GRAPHICS_NO_VIDPNMGR = HResultCode.new('ERROR_GRAPHICS_NO_VIDPNMGR', 0xc0262335, 'Display adapter in question does not have an associated VidPN manager.')

    # (0xc0262336) VidPN manager of the display adapter in question does not have an active VidPN.
    ERROR_GRAPHICS_NO_ACTIVE_VIDPN = HResultCode.new('ERROR_GRAPHICS_NO_ACTIVE_VIDPN', 0xc0262336, 'VidPN manager of the display adapter in question does not have an active VidPN.')

    # (0xc0262337) Specified VidPN topology is stale. Re-acquire the new topology.
    ERROR_GRAPHICS_STALE_VIDPN_TOPOLOGY = HResultCode.new('ERROR_GRAPHICS_STALE_VIDPN_TOPOLOGY', 0xc0262337, 'Specified VidPN topology is stale. Re-acquire the new topology.')

    # (0xc0262338) There is no monitor connected on the specified video present target.
    ERROR_GRAPHICS_MONITOR_NOT_CONNECTED = HResultCode.new('ERROR_GRAPHICS_MONITOR_NOT_CONNECTED', 0xc0262338, 'There is no monitor connected on the specified video present target.')

    # (0xc0262339) Specified source is not part of the specified VidPN topology.
    ERROR_GRAPHICS_SOURCE_NOT_IN_TOPOLOGY = HResultCode.new('ERROR_GRAPHICS_SOURCE_NOT_IN_TOPOLOGY', 0xc0262339, 'Specified source is not part of the specified VidPN topology.')

    # (0xc026233a) Specified primary surface size is invalid.
    ERROR_GRAPHICS_INVALID_PRIMARYSURFACE_SIZE = HResultCode.new('ERROR_GRAPHICS_INVALID_PRIMARYSURFACE_SIZE', 0xc026233a, 'Specified primary surface size is invalid.')

    # (0xc026233b) Specified visible region size is invalid.
    ERROR_GRAPHICS_INVALID_VISIBLEREGION_SIZE = HResultCode.new('ERROR_GRAPHICS_INVALID_VISIBLEREGION_SIZE', 0xc026233b, 'Specified visible region size is invalid.')

    # (0xc026233c) Specified stride is invalid.
    ERROR_GRAPHICS_INVALID_STRIDE = HResultCode.new('ERROR_GRAPHICS_INVALID_STRIDE', 0xc026233c, 'Specified stride is invalid.')

    # (0xc026233d) Specified pixel format is invalid.
    ERROR_GRAPHICS_INVALID_PIXELFORMAT = HResultCode.new('ERROR_GRAPHICS_INVALID_PIXELFORMAT', 0xc026233d, 'Specified pixel format is invalid.')

    # (0xc026233e) Specified color basis is invalid.
    ERROR_GRAPHICS_INVALID_COLORBASIS = HResultCode.new('ERROR_GRAPHICS_INVALID_COLORBASIS', 0xc026233e, 'Specified color basis is invalid.')

    # (0xc026233f) Specified pixel value access mode is invalid.
    ERROR_GRAPHICS_INVALID_PIXELVALUEACCESSMODE = HResultCode.new('ERROR_GRAPHICS_INVALID_PIXELVALUEACCESSMODE', 0xc026233f, 'Specified pixel value access mode is invalid.')

    # (0xc0262340) Specified target is not part of the specified VidPN topology.
    ERROR_GRAPHICS_TARGET_NOT_IN_TOPOLOGY = HResultCode.new('ERROR_GRAPHICS_TARGET_NOT_IN_TOPOLOGY', 0xc0262340, 'Specified target is not part of the specified VidPN topology.')

    # (0xc0262341) Failed to acquire display mode management interface.
    ERROR_GRAPHICS_NO_DISPLAY_MODE_MANAGEMENT_SUPPORT = HResultCode.new('ERROR_GRAPHICS_NO_DISPLAY_MODE_MANAGEMENT_SUPPORT', 0xc0262341, 'Failed to acquire display mode management interface.')

    # (0xc0262342) Specified VidPN source is already owned by a display mode manager (DMM) client and cannot be used until that client releases it.
    ERROR_GRAPHICS_VIDPN_SOURCE_IN_USE = HResultCode.new('ERROR_GRAPHICS_VIDPN_SOURCE_IN_USE', 0xc0262342, 'Specified VidPN source is already owned by a display mode manager (DMM) client and cannot be used until that client releases it.')

    # (0xc0262343) Specified VidPN is active and cannot be accessed.
    ERROR_GRAPHICS_CANT_ACCESS_ACTIVE_VIDPN = HResultCode.new('ERROR_GRAPHICS_CANT_ACCESS_ACTIVE_VIDPN', 0xc0262343, 'Specified VidPN is active and cannot be accessed.')

    # (0xc0262344) Specified VidPN present path importance ordinal is invalid.
    ERROR_GRAPHICS_INVALID_PATH_IMPORTANCE_ORDINAL = HResultCode.new('ERROR_GRAPHICS_INVALID_PATH_IMPORTANCE_ORDINAL', 0xc0262344, 'Specified VidPN present path importance ordinal is invalid.')

    # (0xc0262345) Specified VidPN present path content geometry transformation is invalid.
    ERROR_GRAPHICS_INVALID_PATH_CONTENT_GEOMETRY_TRANSFORMATION = HResultCode.new('ERROR_GRAPHICS_INVALID_PATH_CONTENT_GEOMETRY_TRANSFORMATION', 0xc0262345, 'Specified VidPN present path content geometry transformation is invalid.')

    # (0xc0262346) Specified content geometry transformation is not supported on the respective VidPN present path.
    ERROR_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_SUPPORTED = HResultCode.new('ERROR_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_SUPPORTED', 0xc0262346, 'Specified content geometry transformation is not supported on the respective VidPN present path.')

    # (0xc0262347) Specified gamma ramp is invalid.
    ERROR_GRAPHICS_INVALID_GAMMA_RAMP = HResultCode.new('ERROR_GRAPHICS_INVALID_GAMMA_RAMP', 0xc0262347, 'Specified gamma ramp is invalid.')

    # (0xc0262348) Specified gamma ramp is not supported on the respective VidPN present path.
    ERROR_GRAPHICS_GAMMA_RAMP_NOT_SUPPORTED = HResultCode.new('ERROR_GRAPHICS_GAMMA_RAMP_NOT_SUPPORTED', 0xc0262348, 'Specified gamma ramp is not supported on the respective VidPN present path.')

    # (0xc0262349) Multisampling is not supported on the respective VidPN present path.
    ERROR_GRAPHICS_MULTISAMPLING_NOT_SUPPORTED = HResultCode.new('ERROR_GRAPHICS_MULTISAMPLING_NOT_SUPPORTED', 0xc0262349, 'Multisampling is not supported on the respective VidPN present path.')

    # (0xc026234a) Specified mode is not in the specified mode set.
    ERROR_GRAPHICS_MODE_NOT_IN_MODESET = HResultCode.new('ERROR_GRAPHICS_MODE_NOT_IN_MODESET', 0xc026234a, 'Specified mode is not in the specified mode set.')

    # (0xc026234d) Specified VidPN topology recommendation reason is invalid.
    ERROR_GRAPHICS_INVALID_VIDPN_TOPOLOGY_RECOMMENDATION_REASON = HResultCode.new('ERROR_GRAPHICS_INVALID_VIDPN_TOPOLOGY_RECOMMENDATION_REASON', 0xc026234d, 'Specified VidPN topology recommendation reason is invalid.')

    # (0xc026234e) Specified VidPN present path content type is invalid.
    ERROR_GRAPHICS_INVALID_PATH_CONTENT_TYPE = HResultCode.new('ERROR_GRAPHICS_INVALID_PATH_CONTENT_TYPE', 0xc026234e, 'Specified VidPN present path content type is invalid.')

    # (0xc026234f) Specified VidPN present path copy protection type is invalid.
    ERROR_GRAPHICS_INVALID_COPYPROTECTION_TYPE = HResultCode.new('ERROR_GRAPHICS_INVALID_COPYPROTECTION_TYPE', 0xc026234f, 'Specified VidPN present path copy protection type is invalid.')

    # (0xc0262350) No more than one unassigned mode set can exist at any given time for a given VidPN source or target.
    ERROR_GRAPHICS_UNASSIGNED_MODESET_ALREADY_EXISTS = HResultCode.new('ERROR_GRAPHICS_UNASSIGNED_MODESET_ALREADY_EXISTS', 0xc0262350, 'No more than one unassigned mode set can exist at any given time for a given VidPN source or target.')

    # (0xc0262352) The specified scan line ordering type is invalid.
    ERROR_GRAPHICS_INVALID_SCANLINE_ORDERING = HResultCode.new('ERROR_GRAPHICS_INVALID_SCANLINE_ORDERING', 0xc0262352, 'The specified scan line ordering type is invalid.')

    # (0xc0262353) Topology changes are not allowed for the specified VidPN.
    ERROR_GRAPHICS_TOPOLOGY_CHANGES_NOT_ALLOWED = HResultCode.new('ERROR_GRAPHICS_TOPOLOGY_CHANGES_NOT_ALLOWED', 0xc0262353, 'Topology changes are not allowed for the specified VidPN.')

    # (0xc0262354) All available importance ordinals are already used in the specified topology.
    ERROR_GRAPHICS_NO_AVAILABLE_IMPORTANCE_ORDINALS = HResultCode.new('ERROR_GRAPHICS_NO_AVAILABLE_IMPORTANCE_ORDINALS', 0xc0262354, 'All available importance ordinals are already used in the specified topology.')

    # (0xc0262355) Specified primary surface has a different private format attribute than the current primary surface.
    ERROR_GRAPHICS_INCOMPATIBLE_PRIVATE_FORMAT = HResultCode.new('ERROR_GRAPHICS_INCOMPATIBLE_PRIVATE_FORMAT', 0xc0262355, 'Specified primary surface has a different private format attribute than the current primary surface.')

    # (0xc0262356) Specified mode pruning algorithm is invalid.
    ERROR_GRAPHICS_INVALID_MODE_PRUNING_ALGORITHM = HResultCode.new('ERROR_GRAPHICS_INVALID_MODE_PRUNING_ALGORITHM', 0xc0262356, 'Specified mode pruning algorithm is invalid.')

    # (0xc0262400) Specified display adapter child device already has an external device connected to it.
    ERROR_GRAPHICS_SPECIFIED_CHILD_ALREADY_CONNECTED = HResultCode.new('ERROR_GRAPHICS_SPECIFIED_CHILD_ALREADY_CONNECTED', 0xc0262400, 'Specified display adapter child device already has an external device connected to it.')

    # (0xc0262401) The display adapter child device does not support reporting a descriptor.
    ERROR_GRAPHICS_CHILD_DESCRIPTOR_NOT_SUPPORTED = HResultCode.new('ERROR_GRAPHICS_CHILD_DESCRIPTOR_NOT_SUPPORTED', 0xc0262401, 'The display adapter child device does not support reporting a descriptor.')

    # (0xc0262430) The display adapter is not linked to any other adapters.
    ERROR_GRAPHICS_NOT_A_LINKED_ADAPTER = HResultCode.new('ERROR_GRAPHICS_NOT_A_LINKED_ADAPTER', 0xc0262430, 'The display adapter is not linked to any other adapters.')

    # (0xc0262431) Lead adapter in a linked configuration was not enumerated yet.
    ERROR_GRAPHICS_LEADLINK_NOT_ENUMERATED = HResultCode.new('ERROR_GRAPHICS_LEADLINK_NOT_ENUMERATED', 0xc0262431, 'Lead adapter in a linked configuration was not enumerated yet.')

    # (0xc0262432) Some chain adapters in a linked configuration were not enumerated yet.
    ERROR_GRAPHICS_CHAINLINKS_NOT_ENUMERATED = HResultCode.new('ERROR_GRAPHICS_CHAINLINKS_NOT_ENUMERATED', 0xc0262432, 'Some chain adapters in a linked configuration were not enumerated yet.')

    # (0xc0262433) The chain of linked adapters is not ready to start because of an unknown failure.
    ERROR_GRAPHICS_ADAPTER_CHAIN_NOT_READY = HResultCode.new('ERROR_GRAPHICS_ADAPTER_CHAIN_NOT_READY', 0xc0262433, 'The chain of linked adapters is not ready to start because of an unknown failure.')

    # (0xc0262434) An attempt was made to start a lead link display adapter when the chain links were not started yet.
    ERROR_GRAPHICS_CHAINLINKS_NOT_STARTED = HResultCode.new('ERROR_GRAPHICS_CHAINLINKS_NOT_STARTED', 0xc0262434, 'An attempt was made to start a lead link display adapter when the chain links were not started yet.')

    # (0xc0262435) An attempt was made to turn on a lead link display adapter when the chain links were turned off.
    ERROR_GRAPHICS_CHAINLINKS_NOT_POWERED_ON = HResultCode.new('ERROR_GRAPHICS_CHAINLINKS_NOT_POWERED_ON', 0xc0262435, 'An attempt was made to turn on a lead link display adapter when the chain links were turned off.')

    # (0xc0262436) The adapter link was found to be in an inconsistent state. Not all adapters are in an expected PNP or power state.
    ERROR_GRAPHICS_INCONSISTENT_DEVICE_LINK_STATE = HResultCode.new('ERROR_GRAPHICS_INCONSISTENT_DEVICE_LINK_STATE', 0xc0262436, 'The adapter link was found to be in an inconsistent state. Not all adapters are in an expected PNP or power state.')

    # (0xc0262438) The driver trying to start is not the same as the driver for the posted display adapter.
    ERROR_GRAPHICS_NOT_POST_DEVICE_DRIVER = HResultCode.new('ERROR_GRAPHICS_NOT_POST_DEVICE_DRIVER', 0xc0262438, 'The driver trying to start is not the same as the driver for the posted display adapter.')

    # (0xc0262500) The driver does not support Output Protection Manager (OPM).
    ERROR_GRAPHICS_OPM_NOT_SUPPORTED = HResultCode.new('ERROR_GRAPHICS_OPM_NOT_SUPPORTED', 0xc0262500, 'The driver does not support Output Protection Manager (OPM).')

    # (0xc0262501) The driver does not support Certified Output Protection Protocol (COPP).
    ERROR_GRAPHICS_COPP_NOT_SUPPORTED = HResultCode.new('ERROR_GRAPHICS_COPP_NOT_SUPPORTED', 0xc0262501, 'The driver does not support Certified Output Protection Protocol (COPP).')

    # (0xc0262502) The driver does not support a user-accessible bus (UAB).
    ERROR_GRAPHICS_UAB_NOT_SUPPORTED = HResultCode.new('ERROR_GRAPHICS_UAB_NOT_SUPPORTED', 0xc0262502, 'The driver does not support a user-accessible bus (UAB).')

    # (0xc0262503) The specified encrypted parameters are invalid.
    ERROR_GRAPHICS_OPM_INVALID_ENCRYPTED_PARAMETERS = HResultCode.new('ERROR_GRAPHICS_OPM_INVALID_ENCRYPTED_PARAMETERS', 0xc0262503, 'The specified encrypted parameters are invalid.')

    # (0xc0262504) An array passed to a function cannot hold all of the data that the function wants to put in it.
    ERROR_GRAPHICS_OPM_PARAMETER_ARRAY_TOO_SMALL = HResultCode.new('ERROR_GRAPHICS_OPM_PARAMETER_ARRAY_TOO_SMALL', 0xc0262504, 'An array passed to a function cannot hold all of the data that the function wants to put in it.')

    # (0xc0262505) The GDI display device passed to this function does not have any active video outputs.
    ERROR_GRAPHICS_OPM_NO_VIDEO_OUTPUTS_EXIST = HResultCode.new('ERROR_GRAPHICS_OPM_NO_VIDEO_OUTPUTS_EXIST', 0xc0262505, 'The GDI display device passed to this function does not have any active video outputs.')

    # (0xc0262506) The protected video path (PVP) cannot find an actual GDI display device that corresponds to the passed-in GDI display device name.
    ERROR_GRAPHICS_PVP_NO_DISPLAY_DEVICE_CORRESPONDS_TO_NAME = HResultCode.new('ERROR_GRAPHICS_PVP_NO_DISPLAY_DEVICE_CORRESPONDS_TO_NAME', 0xc0262506, 'The protected video path (PVP) cannot find an actual GDI display device that corresponds to the passed-in GDI display device name.')

    # (0xc0262507) This function failed because the GDI display device passed to it was not attached to the Windows desktop.
    ERROR_GRAPHICS_PVP_DISPLAY_DEVICE_NOT_ATTACHED_TO_DESKTOP = HResultCode.new('ERROR_GRAPHICS_PVP_DISPLAY_DEVICE_NOT_ATTACHED_TO_DESKTOP', 0xc0262507, 'This function failed because the GDI display device passed to it was not attached to the Windows desktop.')

    # (0xc0262508) The PVP does not support mirroring display devices because they do not have video outputs.
    ERROR_GRAPHICS_PVP_MIRRORING_DEVICES_NOT_SUPPORTED = HResultCode.new('ERROR_GRAPHICS_PVP_MIRRORING_DEVICES_NOT_SUPPORTED', 0xc0262508, 'The PVP does not support mirroring display devices because they do not have video outputs.')

    # (0xc026250a) The function failed because an invalid pointer parameter was passed to it. A pointer parameter is invalid if it is null, it points to an invalid address, it points to a kernel mode address, or it is not correctly aligned.
    ERROR_GRAPHICS_OPM_INVALID_POINTER = HResultCode.new('ERROR_GRAPHICS_OPM_INVALID_POINTER', 0xc026250a, 'The function failed because an invalid pointer parameter was passed to it. A pointer parameter is invalid if it is null, it points to an invalid address, it points to a kernel mode address, or it is not correctly aligned.')

    # (0xc026250b) An internal error caused this operation to fail.
    ERROR_GRAPHICS_OPM_INTERNAL_ERROR = HResultCode.new('ERROR_GRAPHICS_OPM_INTERNAL_ERROR', 0xc026250b, 'An internal error caused this operation to fail.')

    # (0xc026250c) The function failed because the caller passed in an invalid OPM user mode handle.
    ERROR_GRAPHICS_OPM_INVALID_HANDLE = HResultCode.new('ERROR_GRAPHICS_OPM_INVALID_HANDLE', 0xc026250c, 'The function failed because the caller passed in an invalid OPM user mode handle.')

    # (0xc026250d) This function failed because the GDI device passed to it did not have any monitors associated with it.
    ERROR_GRAPHICS_PVP_NO_MONITORS_CORRESPOND_TO_DISPLAY_DEVICE = HResultCode.new('ERROR_GRAPHICS_PVP_NO_MONITORS_CORRESPOND_TO_DISPLAY_DEVICE', 0xc026250d, 'This function failed because the GDI device passed to it did not have any monitors associated with it.')

    # (0xc026250e) A certificate could not be returned because the certificate buffer passed to the function was too small.
    ERROR_GRAPHICS_PVP_INVALID_CERTIFICATE_LENGTH = HResultCode.new('ERROR_GRAPHICS_PVP_INVALID_CERTIFICATE_LENGTH', 0xc026250e, 'A certificate could not be returned because the certificate buffer passed to the function was too small.')

    # (0xc026250f) A video output could not be created because the frame buffer is in spanning mode.
    ERROR_GRAPHICS_OPM_SPANNING_MODE_ENABLED = HResultCode.new('ERROR_GRAPHICS_OPM_SPANNING_MODE_ENABLED', 0xc026250f, 'A video output could not be created because the frame buffer is in spanning mode.')

    # (0xc0262510) A video output could not be created because the frame buffer is in theater mode.
    ERROR_GRAPHICS_OPM_THEATER_MODE_ENABLED = HResultCode.new('ERROR_GRAPHICS_OPM_THEATER_MODE_ENABLED', 0xc0262510, 'A video output could not be created because the frame buffer is in theater mode.')

    # (0xc0262511) The function call failed because the display adapter's hardware functionality scan failed to validate the graphics hardware.
    ERROR_GRAPHICS_PVP_HFS_FAILED = HResultCode.new('ERROR_GRAPHICS_PVP_HFS_FAILED', 0xc0262511, 'The function call failed because the display adapter\'s hardware functionality scan failed to validate the graphics hardware.')

    # (0xc0262512) The High-Bandwidth Digital Content Protection (HDCP) System Renewability Message (SRM) passed to this function did not comply with section 5 of the HDCP 1.1 specification.
    ERROR_GRAPHICS_OPM_INVALID_SRM = HResultCode.new('ERROR_GRAPHICS_OPM_INVALID_SRM', 0xc0262512, 'The High-Bandwidth Digital Content Protection (HDCP) System Renewability Message (SRM) passed to this function did not comply with section 5 of the HDCP 1.1 specification.')

    # (0xc0262513) The video output cannot enable the HDCP system because it does not support it.
    ERROR_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_HDCP = HResultCode.new('ERROR_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_HDCP', 0xc0262513, 'The video output cannot enable the HDCP system because it does not support it.')

    # (0xc0262514) The video output cannot enable analog copy protection because it does not support it.
    ERROR_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_ACP = HResultCode.new('ERROR_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_ACP', 0xc0262514, 'The video output cannot enable analog copy protection because it does not support it.')

    # (0xc0262515) The video output cannot enable the Content Generation Management System Analog (CGMS-A) protection technology because it does not support it.
    ERROR_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_CGMSA = HResultCode.new('ERROR_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_CGMSA', 0xc0262515, 'The video output cannot enable the Content Generation Management System Analog (CGMS-A) protection technology because it does not support it.')

    # (0xc0262516) IOPMVideoOutput's GetInformation() method cannot return the version of the SRM being used because the application never successfully passed an SRM to the video output.
    ERROR_GRAPHICS_OPM_HDCP_SRM_NEVER_SET = HResultCode.new('ERROR_GRAPHICS_OPM_HDCP_SRM_NEVER_SET', 0xc0262516, 'IOPMVideoOutput\'s GetInformation() method cannot return the version of the SRM being used because the application never successfully passed an SRM to the video output.')

    # (0xc0262517) IOPMVideoOutput's Configure() method cannot enable the specified output protection technology because the output's screen resolution is too high.
    ERROR_GRAPHICS_OPM_RESOLUTION_TOO_HIGH = HResultCode.new('ERROR_GRAPHICS_OPM_RESOLUTION_TOO_HIGH', 0xc0262517, 'IOPMVideoOutput\'s Configure() method cannot enable the specified output protection technology because the output\'s screen resolution is too high.')

    # (0xc0262518) IOPMVideoOutput's Configure() method cannot enable HDCP because the display adapter's HDCP hardware is already being used by other physical outputs.
    ERROR_GRAPHICS_OPM_ALL_HDCP_HARDWARE_ALREADY_IN_USE = HResultCode.new('ERROR_GRAPHICS_OPM_ALL_HDCP_HARDWARE_ALREADY_IN_USE', 0xc0262518, 'IOPMVideoOutput\'s Configure() method cannot enable HDCP because the display adapter\'s HDCP hardware is already being used by other physical outputs.')

    # (0xc0262519) The operating system asynchronously destroyed this OPM video output because the operating system's state changed. This error typically occurs because the monitor physical device object (PDO) associated with this video output was removed, the monitor PDO associated with this video output was stopped, the video output's session became a nonconsole session or the video output's desktop became an inactive desktop.
    ERROR_GRAPHICS_OPM_VIDEO_OUTPUT_NO_LONGER_EXISTS = HResultCode.new('ERROR_GRAPHICS_OPM_VIDEO_OUTPUT_NO_LONGER_EXISTS', 0xc0262519, 'The operating system asynchronously destroyed this OPM video output because the operating system\'s state changed. This error typically occurs because the monitor physical device object (PDO) associated with this video output was removed, the monitor PDO associated with this video output was stopped, the video output\'s session became a nonconsole session or the video output\'s desktop became an inactive desktop.')

    # (0xc026251a) IOPMVideoOutput's methods cannot be called when a session is changing its type. There are currently three types of sessions: console, disconnected and remote (remote desktop protocol [RDP] or Independent Computing Architecture [ICA]).
    ERROR_GRAPHICS_OPM_SESSION_TYPE_CHANGE_IN_PROGRESS = HResultCode.new('ERROR_GRAPHICS_OPM_SESSION_TYPE_CHANGE_IN_PROGRESS', 0xc026251a, 'IOPMVideoOutput\'s methods cannot be called when a session is changing its type. There are currently three types of sessions: console, disconnected and remote (remote desktop protocol [RDP] or Independent Computing Architecture [ICA]).')

    # (0xc0262580) The monitor connected to the specified video output does not have an I2C bus.
    ERROR_GRAPHICS_I2C_NOT_SUPPORTED = HResultCode.new('ERROR_GRAPHICS_I2C_NOT_SUPPORTED', 0xc0262580, 'The monitor connected to the specified video output does not have an I2C bus.')

    # (0xc0262581) No device on the I2C bus has the specified address.
    ERROR_GRAPHICS_I2C_DEVICE_DOES_NOT_EXIST = HResultCode.new('ERROR_GRAPHICS_I2C_DEVICE_DOES_NOT_EXIST', 0xc0262581, 'No device on the I2C bus has the specified address.')

    # (0xc0262582) An error occurred while transmitting data to the device on the I2C bus.
    ERROR_GRAPHICS_I2C_ERROR_TRANSMITTING_DATA = HResultCode.new('ERROR_GRAPHICS_I2C_ERROR_TRANSMITTING_DATA', 0xc0262582, 'An error occurred while transmitting data to the device on the I2C bus.')

    # (0xc0262583) An error occurred while receiving data from the device on the I2C bus.
    ERROR_GRAPHICS_I2C_ERROR_RECEIVING_DATA = HResultCode.new('ERROR_GRAPHICS_I2C_ERROR_RECEIVING_DATA', 0xc0262583, 'An error occurred while receiving data from the device on the I2C bus.')

    # (0xc0262584) The monitor does not support the specified Virtual Control Panel (VCP) code.
    ERROR_GRAPHICS_DDCCI_VCP_NOT_SUPPORTED = HResultCode.new('ERROR_GRAPHICS_DDCCI_VCP_NOT_SUPPORTED', 0xc0262584, 'The monitor does not support the specified Virtual Control Panel (VCP) code.')

    # (0xc0262585) The data received from the monitor is invalid.
    ERROR_GRAPHICS_DDCCI_INVALID_DATA = HResultCode.new('ERROR_GRAPHICS_DDCCI_INVALID_DATA', 0xc0262585, 'The data received from the monitor is invalid.')

    # (0xc0262586) A function call failed because a monitor returned an invalid Timing Status byte when the operating system used the Display Data Channel Command Interface (DDC/CI) Get Timing Report and Timing Message command to get a timing report from a monitor.
    ERROR_GRAPHICS_DDCCI_MONITOR_RETURNED_INVALID_TIMING_STATUS_BYTE = HResultCode.new('ERROR_GRAPHICS_DDCCI_MONITOR_RETURNED_INVALID_TIMING_STATUS_BYTE', 0xc0262586, 'A function call failed because a monitor returned an invalid Timing Status byte when the operating system used the Display Data Channel Command Interface (DDC/CI) Get Timing Report and Timing Message command to get a timing report from a monitor.')

    # (0xc0262587) The monitor returned a DDC/CI capabilities string that did not comply with the ACCESS.bus 3.0, DDC/CI 1.1 or MCCS 2 Revision 1 specification.
    ERROR_GRAPHICS_MCA_INVALID_CAPABILITIES_STRING = HResultCode.new('ERROR_GRAPHICS_MCA_INVALID_CAPABILITIES_STRING', 0xc0262587, 'The monitor returned a DDC/CI capabilities string that did not comply with the ACCESS.bus 3.0, DDC/CI 1.1 or MCCS 2 Revision 1 specification.')

    # (0xc0262588) An internal Monitor Configuration API error occurred.
    ERROR_GRAPHICS_MCA_INTERNAL_ERROR = HResultCode.new('ERROR_GRAPHICS_MCA_INTERNAL_ERROR', 0xc0262588, 'An internal Monitor Configuration API error occurred.')

    # (0xc0262589) An operation failed because a DDC/CI message had an invalid value in its command field.
    ERROR_GRAPHICS_DDCCI_INVALID_MESSAGE_COMMAND = HResultCode.new('ERROR_GRAPHICS_DDCCI_INVALID_MESSAGE_COMMAND', 0xc0262589, 'An operation failed because a DDC/CI message had an invalid value in its command field.')

    # (0xc026258a) This error occurred because a DDC/CI message length field contained an invalid value.
    ERROR_GRAPHICS_DDCCI_INVALID_MESSAGE_LENGTH = HResultCode.new('ERROR_GRAPHICS_DDCCI_INVALID_MESSAGE_LENGTH', 0xc026258a, 'This error occurred because a DDC/CI message length field contained an invalid value.')

    # (0xc026258b) This error occurred because the value in a DDC/CI message checksum field did not match the message's computed checksum value. This error implies that the data was corrupted while it was being transmitted from a monitor to a computer.
    ERROR_GRAPHICS_DDCCI_INVALID_MESSAGE_CHECKSUM = HResultCode.new('ERROR_GRAPHICS_DDCCI_INVALID_MESSAGE_CHECKSUM', 0xc026258b, 'This error occurred because the value in a DDC/CI message checksum field did not match the message\'s computed checksum value. This error implies that the data was corrupted while it was being transmitted from a monitor to a computer.')

    # (0xc02625d6) The HMONITOR no longer exists, is not attached to the desktop, or corresponds to a mirroring device.
    ERROR_GRAPHICS_PMEA_INVALID_MONITOR = HResultCode.new('ERROR_GRAPHICS_PMEA_INVALID_MONITOR', 0xc02625d6, 'The HMONITOR no longer exists, is not attached to the desktop, or corresponds to a mirroring device.')

    # (0xc02625d7) The Direct3D (D3D) device's GDI display device no longer exists, is not attached to the desktop, or is a mirroring display device.
    ERROR_GRAPHICS_PMEA_INVALID_D3D_DEVICE = HResultCode.new('ERROR_GRAPHICS_PMEA_INVALID_D3D_DEVICE', 0xc02625d7, 'The Direct3D (D3D) device\'s GDI display device no longer exists, is not attached to the desktop, or is a mirroring display device.')

    # (0xc02625d8) A continuous VCP code's current value is greater than its maximum value. This error code indicates that a monitor returned an invalid value.
    ERROR_GRAPHICS_DDCCI_CURRENT_CURRENT_VALUE_GREATER_THAN_MAXIMUM_VALUE = HResultCode.new('ERROR_GRAPHICS_DDCCI_CURRENT_CURRENT_VALUE_GREATER_THAN_MAXIMUM_VALUE', 0xc02625d8, 'A continuous VCP code\'s current value is greater than its maximum value. This error code indicates that a monitor returned an invalid value.')

    # (0xc02625d9) The monitor's VCP Version (0xDF) VCP code returned an invalid version value.
    ERROR_GRAPHICS_MCA_INVALID_VCP_VERSION = HResultCode.new('ERROR_GRAPHICS_MCA_INVALID_VCP_VERSION', 0xc02625d9, 'The monitor\'s VCP Version (0xDF) VCP code returned an invalid version value.')

    # (0xc02625da) The monitor does not comply with the Monitor Control Command Set (MCCS) specification it claims to support.
    ERROR_GRAPHICS_MCA_MONITOR_VIOLATES_MCCS_SPECIFICATION = HResultCode.new('ERROR_GRAPHICS_MCA_MONITOR_VIOLATES_MCCS_SPECIFICATION', 0xc02625da, 'The monitor does not comply with the Monitor Control Command Set (MCCS) specification it claims to support.')

    # (0xc02625db) The MCCS version in a monitor's mccs_ver capability does not match the MCCS version the monitor reports when the VCP Version (0xDF) VCP code is used.
    ERROR_GRAPHICS_MCA_MCCS_VERSION_MISMATCH = HResultCode.new('ERROR_GRAPHICS_MCA_MCCS_VERSION_MISMATCH', 0xc02625db, 'The MCCS version in a monitor\'s mccs_ver capability does not match the MCCS version the monitor reports when the VCP Version (0xDF) VCP code is used.')

    # (0xc02625dc) The Monitor Configuration API only works with monitors that support the MCCS 1.0 specification, the MCCS 2.0 specification, or the MCCS 2.0 Revision 1 specification.
    ERROR_GRAPHICS_MCA_UNSUPPORTED_MCCS_VERSION = HResultCode.new('ERROR_GRAPHICS_MCA_UNSUPPORTED_MCCS_VERSION', 0xc02625dc, 'The Monitor Configuration API only works with monitors that support the MCCS 1.0 specification, the MCCS 2.0 specification, or the MCCS 2.0 Revision 1 specification.')

    # (0xc02625de) The monitor returned an invalid monitor technology type. CRT, plasma, and LCD (TFT) are examples of monitor technology types. This error implies that the monitor violated the MCCS 2.0 or MCCS 2.0 Revision 1 specification.
    ERROR_GRAPHICS_MCA_INVALID_TECHNOLOGY_TYPE_RETURNED = HResultCode.new('ERROR_GRAPHICS_MCA_INVALID_TECHNOLOGY_TYPE_RETURNED', 0xc02625de, 'The monitor returned an invalid monitor technology type. CRT, plasma, and LCD (TFT) are examples of monitor technology types. This error implies that the monitor violated the MCCS 2.0 or MCCS 2.0 Revision 1 specification.')

    # (0xc02625df) The SetMonitorColorTemperature() caller passed a color temperature to it that the current monitor did not support. CRT, plasma, and LCD (TFT) are examples of monitor technology types. This error implies that the monitor violated the MCCS 2.0 or MCCS 2.0 Revision 1 specification.
    ERROR_GRAPHICS_MCA_UNSUPPORTED_COLOR_TEMPERATURE = HResultCode.new('ERROR_GRAPHICS_MCA_UNSUPPORTED_COLOR_TEMPERATURE', 0xc02625df, 'The SetMonitorColorTemperature() caller passed a color temperature to it that the current monitor did not support. CRT, plasma, and LCD (TFT) are examples of monitor technology types. This error implies that the monitor violated the MCCS 2.0 or MCCS 2.0 Revision 1 specification.')

    # (0xc02625e0) This function can be used only if a program is running in the local console session. It cannot be used if the program is running on a remote desktop session or on a terminal server session.
    ERROR_GRAPHICS_ONLY_CONSOLE_SESSION_SUPPORTED = HResultCode.new('ERROR_GRAPHICS_ONLY_CONSOLE_SESSION_SUPPORTED', 0xc02625e0, 'This function can be used only if a program is running in the local console session. It cannot be used if the program is running on a remote desktop session or on a terminal server session.')

  end
end
