TankExt.PrecacheSound("Building_Sentry.Damage")
bHasSapperLast <- false
iHealthLast <- 0
flNextDamage <- 0
flTimeRemove <- 0
SentrySapThink <- function()
{
	if(!self.IsValid()) return
	local bHasSapper = GetPropBool(self, "m_bHasSapper")
	if(bHasSapper)
	{
		local hSapper = self.FirstMoveChild()
		local flTime = Time()
		if(!bHasSapperLast)
		{
			flTimeRemove = flTime + 8
			EmitSoundOn("Building_Sentry.Damage", self)
			SetPropEntity(hSapper, "m_hBuilder", null)
			EntFireByHandle(self, "SetHealth", iHealthLast.tostring(), 0.1, null, null)
		}
		if(flTime >= flTimeRemove)
			hSapper.AcceptInput("RemoveHealth", (hSapper.GetHealth() * 4).tostring(), null, null)
	}
	iHealthLast = self.GetHealth()
	bHasSapperLast = bHasSapper
	return -1
}
TankExt.AddThinkToEnt(self, "SentrySapThink")