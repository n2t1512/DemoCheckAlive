# -*- coding: utf8 -*-
import os, sys
import telebot


def send_rp():
    token = '1148822311:AAFThyV7UGS-AO-SWWHaFpVPaxy9Txwwhfo'
    tb = telebot.TeleBot(token)
    # getMe
    user = tb.get_me()
    print(user)
    update = tb.get_updates()
    #chat_id = '-399957625'
    # "id":-455242518, #"title":"FPT Report BONG"
    #chat_id = '-399957625' # "title":"MOBI 4G Report BONG"
     # "title":"VNPT Report BONG"
    # "id":-488422190,"title":"VT Report BONG"
    # "id":-591520666,"title":"FPT Demo"
    # test id: -464557426
    # my test id: -416083095
    #os.getcwd() +r'\588\TESTS\
    #Khai bao bien sai chung cho
    ID_chat = ["-455242518", "-399957625", "-400071378", "-488422190"]
    Name_chat = ["FPT_B2_Lotte.txt", "Mobi_B2_Lotte.txt", "VNPT_B2_Lotte.txt", "VT_B2_Lotte.txt"]
    msg = 'No issue in B2_Lotte.'
    chat_id = ID_chat[0]
    #ID_chat[0]
    if '-455' in chat_id:
        report_path = Name_chat[0]
    elif '-399' in chat_id:
        report_path = Name_chat[1]
    elif '-400' in chat_id:
        report_path = Name_chat[2]
    elif '591' in chat_id:
        report_path = Name_chat[0]
    else:
        report_path = Name_chat[3]   
    # print(chat_id)
    # print(report_path)
    with open(report_path, 'r') as f:
        content = f.read()
        if 'FAILED' in content:
            doc = open(report_path, 'rb')
            tb.send_document(chat_id, doc)
            # tb.send_message(chat_id, msg)
        else:
            tb.send_message(chat_id, msg)
        doc.close()
        
if __name__ == '__main__':
    send_rp()
