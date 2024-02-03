package models

type ChannelMember struct {
	ChannelID uint64 `gorm:"column:channel_id"`
	UserID    uint64 `gorm:"column:user_id"`
}
