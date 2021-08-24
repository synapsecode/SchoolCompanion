import io
import os
import numpy as np
import pandas as pd
import time
from cloudinary.uploader import upload
from cloudinary.utils import cloudinary_url
from flask import jsonify
import onesignal_sdk


def extract_excel_data(provider_type, fileobject):
	try:
		if(provider_type == "bytes"):
			# Get the DataFrame
			df = pd.read_excel(fileobject, sheet_name='Sheet1')
			headers = [x for x in df]  # Get all the Headers of the Excel File
			# Convert the DataFrame to a python Dictionary
			df = df.to_dict(orient='list')
			student_objects = []  # This list stores all the Student Objects
			# Gets the total number of columns in the Excel Sheet
			num_rows = len(df['id'])

			# Student Dictionary Creation
			for i in range(num_rows):
				student_object = {}
				for header in headers:
					value = df[header][i]
					student_object[header] = value if not (
						value is np.nan or value != value) else ""
				student_objects.append(student_object)

			print("COMPLETED REQUEST")
			return({
				'data': student_objects,
				'dcount': num_rows,
				'status': 'OK'
			})
	except Exception as e:
		print(e)
		return({
			'status': 'ERR',
			'errcode': str(e)
		})
	finally:
		pass


def upload_file_to_cloud(filebytes, filetype=None):
	try:
		start = time.time()
		# Initialize Variables
		objectURI = ""
		if(filetype != None):
			uploaded_object = upload(filebytes,
									 notification_url="http://localhost",
									 api_key="597356837268799",
									 resource_type=str(filetype),
									 api_secret="MgLEKQS1aHJs6TVkGNrv-mfneY0",
									 cloud_name="krustel-inc"
									 )
			objectURI = uploaded_object['secure_url']
		else:
			uploaded_object = upload(filebytes,
									 notification_url="http://localhost",
									 api_key="597356837268799",
									 api_secret="MgLEKQS1aHJs6TVkGNrv-mfneY0",
									 cloud_name="krustel-inc"
									 )
			objectURI = uploaded_object['secure_url']

		end = time.time()
		print(f"TOOK {int(end-start)} seconds to finish")
		return({
			"STATUS": "OK",
			"URI": str(objectURI),
		})
	except Exception as e:
		print(e)
		return({
			"STATUS": "ERR",
			"ERRCODE": str(e)
		})


def PushNotifyUsers(title, message, grade, ntype):
	# Specify Keys
	REST_API_KEY = "OTllNmJkMmQtNzQ1YS00YTQyLWJhOTEtNzI1NDUwYTI1Zjkw"
	APP_ID = "0226e2d0-cc32-4ec7-9315-f34981cedcd7"
	# create a onesignal client
	onesignal_client = onesignal_sdk.Client(
		app_auth_key=REST_API_KEY, app_id=APP_ID)
	# create a notification
	new_notification = onesignal_sdk.Notification(post_body={
		"headings": {"en": title},
		"contents": {"en": message},
		"included_segments": ["Active Users"],
	})

	new_notification.post_body["data"] = {"class": grade, "NTYPE": ntype}

	# send notification, it will return a response
	onesignal_response = onesignal_client.send_notification(new_notification)
	print(onesignal_response.status_code)
	print(onesignal_response.json())


def getSubject(s):
	return ("Physics" if s == "PHY" else "Chemistry" if s == "CHEM" else "Biology" if s == "BIO" else "Mathematics" if s == "MAT"
			else "History & Civics" if s == "HIS" else "GEO" if s == 'GEO' else "English Grammar" if s == 'ENG1' else "English Literature"
			if s == "ENG2" else "Computer Applications" if s == 'COMP' else "Physical Education" if s == 'PE' else "Second Language" if s == 'LNG' else "Miscellaneous")
