
define RUBYFPV_EXTRACT_CMDS
	cp -avr $(RUBYFPV_PKGDIR)/src/* $(@D)/
	cp -avr $(RUBYFPV_PKGDIR)/files/* $(@D)/
endef

define RUBYFPV_BUILD_CMDS
	(cd $(@D); $(TARGET_CC) -s ruby_start.c -o ruby_start)
	(cd $(@D); $(TARGET_CC) -s ruby_start.c -o ruby_logger)
	(cd $(@D); $(TARGET_CC) -s ruby_start.c -o ruby_rt_vehicle)
	(cd $(@D); $(TARGET_CC) -s ruby_start.c -o ruby_tx_telemetry)
	(cd $(@D); $(TARGET_CC) -s ruby_start.c -o ruby_rx_commands)
endef

define RUBYFPV_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 -d $(TARGET_DIR)/etc/init.d
	$(INSTALL) -m 755 -d $(TARGET_DIR)/usr/sbin
	$(INSTALL) -m 755 -d $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 755 -d $(TARGET_DIR)/root/ruby
 
	cp $(RUBYFPV_PKGDIR)/files/S73ruby $(TARGET_DIR)/etc/init.d
	chmod 755 $(TARGET_DIR)/etc/init.d/S73ruby

	install -m 0755 -D $(@D)/ruby_start $(TARGET_DIR)/usr/sbin/ruby_start
	install -m 0755 -D $(@D)/ruby_logger $(TARGET_DIR)/usr/sbin/ruby_logger
	install -m 0755 -D $(@D)/ruby_rt_vehicle $(TARGET_DIR)/usr/sbin/ruby_rt_vehicle
	install -m 0755 -D $(@D)/ruby_tx_telemetry $(TARGET_DIR)/usr/sbin/ruby_tx_telemetry
	install -m 0755 -D $(@D)/ruby_rx_commands $(TARGET_DIR)/usr/sbin/ruby_rx_commands

	cp $(RUBYFPV_PKGDIR)/files/ruby_stop.sh $(TARGET_DIR)/usr/sbin
	chmod 755 $(TARGET_DIR)/usr/sbin/ruby_stop.sh
	cp $(RUBYFPV_PKGDIR)/files/tweaksys $(TARGET_DIR)/usr/bin
	cp -r $(RUBYFPV_PKGDIR)/files/licences $(TARGET_DIR)/root/ruby/
	cp $(RUBYFPV_PKGDIR)/files/version_ruby_base.txt $(TARGET_DIR)/usr/sbin
endef

$(eval $(generic-package))
