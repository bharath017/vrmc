package com.willka.soft.util;

import java.io.File;

public class DocumentUtil {

	public static boolean deleteFiles(String fileName) {
		try {
			File fileObj=new File(fileName);
			if(fileObj.delete())
				return true;
			else
				return false;
		}catch(Exception e) {
			return false;
		}
		
	}
}
