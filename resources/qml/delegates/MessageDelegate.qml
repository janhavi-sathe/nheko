import QtQuick 2.6
import im.nheko 1.0

Item {
	// Workaround to have an assignable global property
	Item {
		id: model
		property var data;
	}
	
	property alias modelData: model.data

	height: chooser.childrenRect.height

	DelegateChooser {
		id: chooser
		//role: "type" //< not supported in our custom implementation, have to use roleValue
		roleValue: model.data.type
		anchors.fill: parent

		DelegateChoice {
			roleValue: MtxEvent.UnknownMessage
			Placeholder { text: "Unretrieved event" }
		}
		DelegateChoice {
			roleValue: MtxEvent.TextMessage
			TextMessage {}
		}
		DelegateChoice {
			roleValue: MtxEvent.NoticeMessage
			NoticeMessage {}
		}
		DelegateChoice {
			roleValue: MtxEvent.EmoteMessage
			NoticeMessage {
				formatted: chat.model.escapeEmoji(modelData.userName) + " " + model.data.formattedBody
				color: timelineManager.userColor(modelData.userId, colors.window)
			}
		}
		DelegateChoice {
			roleValue: MtxEvent.ImageMessage
			ImageMessage {}
		}
		DelegateChoice {
			roleValue: MtxEvent.Sticker
			ImageMessage {}
		}
		DelegateChoice {
			roleValue: MtxEvent.FileMessage
			FileMessage {}
		}
		DelegateChoice {
			roleValue: MtxEvent.VideoMessage
			PlayableMediaMessage {}
		}
		DelegateChoice {
			roleValue: MtxEvent.AudioMessage
			PlayableMediaMessage {}
		}
		DelegateChoice {
			roleValue: MtxEvent.Redacted
			Pill {
				text: qsTr("redacted")
			}
		}
		DelegateChoice {
			roleValue: MtxEvent.Encryption
			Pill {
				text: qsTr("Encryption enabled")
			}
		}
		DelegateChoice {
			roleValue: MtxEvent.Name
			NoticeMessage {
				text: model.data.roomName ? qsTr("room name changed to: %1").arg(model.data.roomName) : qsTr("removed room name")
			}
		}
		DelegateChoice {
			roleValue: MtxEvent.Topic
			NoticeMessage {
				text: model.data.roomTopic ? qsTr("topic changed to: %1").arg(model.data.roomTopic) : qsTr("removed topic")
			}
		}
		DelegateChoice {
			roleValue: MtxEvent.RoomCreate
			NoticeMessage {
				text: qsTr("%1 created and configured room: %2").arg(model.data.userName).arg(model.data.roomId)
			}
		}
		DelegateChoice {
			// TODO: make a more complex formatter for the power levels.
			roleValue: MtxEvent.PowerLevels
			NoticeMessage {
				text: timelineManager.timeline.formatPowerLevelEvent(model.data.id)
			}
		}
		DelegateChoice {
			roleValue: MtxEvent.RoomJoinRules
			NoticeMessage {
				text: timelineManager.timeline.formatJoinRuleEvent(model.data.id)
			}
		}
		DelegateChoice {
			roleValue: MtxEvent.RoomHistoryVisibility
			NoticeMessage {
				text: timelineManager.timeline.formatHistoryVisibilityEvent(model.data.id)
			}
		}
		DelegateChoice {
			roleValue: MtxEvent.RoomGuestAccess
			NoticeMessage {
				text: timelineManager.timeline.formatGuestAccessEvent(model.data.id)
			}
		}
		DelegateChoice {
			roleValue: MtxEvent.Member
			NoticeMessage {
				text: timelineManager.timeline.formatMemberEvent(model.data.id);
			}
		}
		DelegateChoice {
			Placeholder {}
		}
	}
}
