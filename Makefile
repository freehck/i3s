CFG_DIR=$(DESTDIR)/etc/i3s
PLUGINS_DIR=$(DESTDIR)/usr/lib/i3s/plugins
BIN_DIR=$(DESTDIR)/usr/bin

INSTALL=install
INS_OPTS = -o root -g root

SCRIPT=$(BIN_DIR)/i3s
PLUGINS = time load ram mpd layout volume

install:
	$(INSTALL) $(INS_OPTS) -d $(CFG_DIR) $(PLUGINS_DIR) $(BIN_DIR)
	$(INSTALL) $(INS_OPTS) i3s.conf $(CFG_DIR)
	$(INSTALL) $(INS_OPTS) i3s $(BIN_DIR)
	for plugin in $(PLUGINS); do\
	  $(INSTALL) $(INS_OPTS) plugins/$$plugin.sh $(PLUGINS_DIR);\
	done

remove:
	rm -rf $(CFG_DIR) $(PLUGINS_DIR) $(SCRIPT)
