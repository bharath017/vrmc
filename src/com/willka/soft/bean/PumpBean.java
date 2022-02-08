package com.willka.soft.bean;

public class PumpBean {
	
        private	int pump_id;
        
        private String pump_name;
        
        

		public int getPump_id() {
			return pump_id;
		}

		public void setPump_id(int pump_id) {
			this.pump_id = pump_id;
		}

		public String getPump_name() {
			return pump_name;
		}

		public void setPump_name(String pump_name) {
			this.pump_name = pump_name;
		}

		@Override
		public String toString() {
			return "PumpBean [pump_id=" + pump_id + ", pump_name=" + pump_name + "]";
		}
	

}
