-------------------------------------------------
--  Projet : des IOT a base de nodemcu (ESP8266)
--           qui communiquent en MQTT
-------------------------------------------------
--  Auteur : FredThx  
-------------------------------------------------
--  Ce fichier : paramètres pour nodemcu CROQUETTES
--               avec
--                    - ecran LCD en i2c
--                    - 1 bouton
--                      - grove gesture en i2c
-------------------------------------------------

LOGGER = false

--------------------------------------
-- PARAMETRES CAPTEURS - ACTIONEURS
--------------------------------------

-- display et grove gesture en i2c
pin_sda = 5 
pin_scl = 6 

pin_bt = 1

--------------------------------------
-- Modules a charger
--------------------------------------
modules={"i2c_lcd", "i2c_geste"}

--------------------------------------
-- Params WIFI 
--------------------------------------
SSID = {"WIFI_THOME1",'WIFI_THOME2'}
PASSWORD = "plus33324333562"
HOST = "NODE-CROQ"
wifi_time_retry = 10 -- minutes

----------------------------------------
-- Params MQTT
----------------------------------------
mqtt_host = "192.168.10.155"
mqtt_port = 1883
mqtt_user = "fredthx"
mqtt_pass = "GaZoBu"
mqtt_client_name = HOST
mqtt_base_topic = "T-HOME/CROQ/"
--Gestes
GEST_TOPIC = mqtt_base_topic.."GESTE"

----------------------------------------
-- Messages MQTT sortants
---------------------------------------- 
mesure_period = 1*60 * 1000
mqtt_out_topics = {}

-- Messages MQTT sortants sur test
test_period = 1000
test_init = false
mqtt_test_topics = {}
mqtt_test_topics[mqtt_base_topic.."INIT"]={{
                test = function()
                        if test_init then
                            return false
                        else
                            test_init = true
                            return true
                        end
                    end,
                value = "INIT",
                mqtt_repeat = false,
                qos = 0, retain = 0, callback = nil}}
----------------------------------------
-- Messages sur trigger GPIO
----------------------------------------
mqtt_trig_topics = {}
mqtt_trig_topics[mqtt_base_topic.."BT"]={
                pin = pin_bt,
                pullup = true,
                type = "down", -- or "down", "both", "low", "high"
                qos = 0, retain = 0, callback = nil,
                message = function()
                        print("Bt pushed")
                        --mqtt_in_topics[mqtt_base_topic.."RELAIS"]["CHANGE"]()
                        -- TODO : régler problème de déclenchement intempestif quand relais activé via WIFI
                        return gpio.read(pin_bt)
                    end
                }  
----------------------------------------
-- Actions sur messages MQTT entrants
----------------------------------------
mqtt_in_topics = {}
----------------------------------------
--Gestion du display : mqtt(json)=>affichage
----------------------------------------
mqtt_in_topics[mqtt_base_topic.."DISPLAY"]=function(data)
                disp_add_data(data)
            end
            
