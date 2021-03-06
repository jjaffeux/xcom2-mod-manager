class AppDelegate
  def applicationDidFinishLaunching notification
    @library = ModLibrary.new

    @status_item = NSStatusBar.systemStatusBar.statusItemWithLength NSVariableStatusItemLength
    @status_item.setHighlightMode false
    @status_item.setTitle 'xc2mods'
    @status_item.setTarget self
    @status_item.setMenu create_mods_menu
  end

  def create_mods_menu
    NSMenu.new.tap do |menu|
      menu.initWithTitle ''

      @library.all.each do |mod|
        menu.addItem NSMenuItem.create(title: mod.name, action: 'clicked_menu_bar:', enabled: mod.enabled)
      end

      menu.addItem NSMenuItem.separatorItem
      menu.addItem NSMenuItem.create title: "version #{version}"
      menu.addItem NSMenuItem.create title: 'Quit xc2mod manager', action: 'terminate:'
    end
  end

  def version
    'CFBundleShortVersionString'.info_plist
  end

  def clicked_menu_bar item
    item.toggle!

    action = item.checked? ? :enable : :disable
    @library.send action, item.title
  end
end
