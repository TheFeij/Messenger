package models

type ChatParticipant struct {
	ChatID uint64 `gorm:"column:chat_id"`
	UserID uint64 `gorm:"column:user_id"`
}
